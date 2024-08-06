#ifndef LOOP_SERIALIZATION_PASSES
#define LOOP_SERIALIZATION_PASSES

include "mlir/Pass/PassBase.td"

def LoopSerialization : Pass<"inner-loop-serialization"> {
    let summary = "Replace inner scf.parallel with scf.for";
    let dependentDialects =
        ["scf::SCFDialect"];
    let constructor = "mlir::loopSerialization::createLoopSerializationPass()";
}

#endif // LOOP_SERIALIZATION_PASSES
