#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/Arith/IR/Arith.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Dialect/Math/IR/Math.h"
#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/Dialect/SCF/IR/SCF.h"

#include "mlir/Pass/PassRegistry.h"
#include "mlir/Tools/mlir-opt/MlirOptMain.h"

#include "Passes.h"

using namespace mlir;

int main(int argc, char **argv) {
    mlir::DialectRegistry registry;

    registry.insert<mlir::affine::AffineDialect>();
    //registry.insert<mlir::LLVM::LLVMDialect>();
    registry.insert<mlir::memref::MemRefDialect>();
    registry.insert<mlir::func::FuncDialect>();
    registry.insert<mlir::arith::ArithDialect>();
    registry.insert<mlir::scf::SCFDialect>();
    registry.insert<mlir::math::MathDialect>();

    mlir::registerloopSerializationPasses();
    //allowUnregisteredDialects()
    return mlir::failed(mlir::MlirOptMain(
        argc, argv, "Inner scf parallel loop serialization", registry));
}
