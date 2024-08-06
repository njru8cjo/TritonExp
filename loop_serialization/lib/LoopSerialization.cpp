#include "Passes.h"

//#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/Dialect/SCF/IR/SCF.h"
#include "mlir/Dialect/Arith/IR/Arith.h"

#include "mlir/IR/ImplicitLocOpBuilder.h"
#include "mlir/Transforms/GreedyPatternRewriteDriver.h"

namespace mlir {
namespace loopSerialization {
#define GEN_PASS_DECL_LOOPSERIALIZATION
#define GEN_PASS_DEF_LOOPSERIALIZATION
#include "Passes.h.inc"
}
}

using namespace mlir;

struct LoopSerialization : public loopSerialization::impl::LoopSerializationBase<LoopSerialization> {
    using LoopSerializationBase::LoopSerializationBase;
    LoopSerialization() = default;

    void runOnOperation() override;
};

struct SubstituteInnerParallelOp : public OpRewritePattern<scf::ParallelOp> {
    SubstituteInnerParallelOp(MLIRContext *context)
        : OpRewritePattern<scf::ParallelOp>(context, /*benefit=*/1) {}
    using OpRewritePattern<scf::ParallelOp>::OpRewritePattern;

    LogicalResult matchAndRewrite(scf::ParallelOp parallelOp, PatternRewriter &rewriter) const final {
        // Deal with inner loop
        SmallVector<scf::ParallelOp> eraseInnerParallelOp;
        for (Operation& innerOp : parallelOp.getBody()->getOperations()) {
            if (scf::ParallelOp innerParallelOp = dyn_cast<scf::ParallelOp>(innerOp)) {
                ImplicitLocOpBuilder builder(innerParallelOp.getLoc(), rewriter);
                SmallVector<scf::ForOp> forOp(innerParallelOp.getNumLoops());
                // Multi-dimension parallel loop to nested for loop
                for (size_t index = 0; index < innerParallelOp.getNumLoops(); ++index) {
                    if (index == 0) {
                        builder.setInsertionPoint(innerParallelOp);
                    }
                    else {
                        builder.setInsertionPoint(forOp[index - 1].getBody(), forOp[index - 1].getBody()->begin());
                    }
                    forOp[index] = builder.create<scf::ForOp>(innerParallelOp.getLowerBound()[index],
                                                              innerParallelOp.getUpperBound()[index],
                                                              innerParallelOp.getStep()[index]);
                    innerParallelOp.getInductionVars()[index].replaceAllUsesWith(forOp[index].getInductionVar());
                }
                // For loop does not use reduceOp
                for (Operation& innerInnerOp : innerParallelOp) {
                    if (scf::ReduceOp reduceOp = dyn_cast<scf::ReduceOp>(innerInnerOp)) {
                        // We are using "for (A : B)". We can't eraseOp here.
                        rewriter.eraseOp(reduceOp);
                        break;
                    }
                }
                // Move the body of inner parallel loop to the deepest for loop
                forOp[innerParallelOp.getNumLoops() - 1].getBody()->getOperations().splice(
                    forOp[innerParallelOp.getNumLoops() - 1].getBody()->begin(),
                    innerParallelOp.getBody()->getOperations());
                // We are using "for (A : B)". We can't eraseOp here.
                eraseInnerParallelOp.push_back(innerParallelOp);
            }
        }
        for (size_t index = 0; index < eraseInnerParallelOp.size(); ++index) {
            rewriter.eraseOp(eraseInnerParallelOp[index]);
        }
        // Only keep the first induction variable for the outer loop
        if (parallelOp.getNumLoops() >= 2) {
            ImplicitLocOpBuilder builder(parallelOp.getLoc(), rewriter);
            builder.setInsertionPoint(parallelOp);
            scf::ParallelOp newParallelOp = builder.create<scf::ParallelOp>(parallelOp.getLowerBound()[0],
                                                                            parallelOp.getUpperBound()[0],
                                                                            parallelOp.getStep()[0]);
            parallelOp.getInductionVars()[0].replaceAllUsesWith(newParallelOp.getInductionVars()[0]);    
            SmallVector<scf::ForOp> forOp(parallelOp.getNumLoops());
            for (size_t index = 1; index < parallelOp.getNumLoops(); ++index) {
                if (index == 1) {
                    builder.setInsertionPoint(newParallelOp.getBody(), newParallelOp.getBody()->begin());
                }
                else {
                    builder.setInsertionPoint(forOp[index - 1].getBody(), forOp[index - 1].getBody()->begin());
                }
                forOp[index] = builder.create<scf::ForOp>(parallelOp.getLowerBound()[index],
                                                          parallelOp.getUpperBound()[index],
                                                          parallelOp.getStep()[index]);
                parallelOp.getInductionVars()[index].replaceAllUsesWith(forOp[index].getInductionVar());
            }
            // Move the body of outer parallel loop to the deepest for loop produced by parallelOp
            forOp[parallelOp.getNumLoops() - 1].getBody()->getOperations().splice(
                forOp[parallelOp.getNumLoops() - 1].getBody()->begin(),
                parallelOp.getBody()->getOperations());
            rewriter.replaceOp(parallelOp, newParallelOp);
            // For loop does not use reduceOp
            for (size_t index = 1; index < parallelOp.getNumLoops(); ++index) {
                for (Operation& innerInnerOp : forOp[index]) {
                    if (scf::ReduceOp reduceOp = dyn_cast<scf::ReduceOp>(innerInnerOp)) {
                        // We are using "for (A : B)". We can't eraseOp here.
                        rewriter.eraseOp(reduceOp);
                        break;
                    }
                }
            }
            parallelOp = newParallelOp;
        }
        //parallelOp.emitWarning();
        return success();
    }
};

void LoopSerialization::runOnOperation() {
    MLIRContext *context = &getContext();
    RewritePatternSet patterns(context);
    patterns.add<SubstituteInnerParallelOp>(context);
    GreedyRewriteConfig config;
    (void)applyPatternsAndFoldGreedily(getOperation(), std::move(patterns), config);
}

namespace mlir {
namespace loopSerialization {
std::unique_ptr<mlir::Pass> createLoopSerializationPass() {
    return std::make_unique<LoopSerialization>();
}
}
}
