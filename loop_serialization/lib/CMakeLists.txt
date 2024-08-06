add_mlir_conversion_library(MLIRLoopSerializationTransforms
LoopSerialization.cpp

DEPENDS
MLIRLoopSerializationPassIncGen

LINK_LIBS PUBLIC
# MLIRAffineDialect
# MLIRControlFlowDialect
# MLIRFuncDialect
# MLIRLLVMDialect
# MLIRMemRefDialect
MLIRSCFDialect
)