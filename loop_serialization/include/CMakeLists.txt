set(LLVM_TARGET_DEFINITIONS Passes.td)
mlir_tablegen(Passes.h.inc -gen-pass-decls -name loopSerialization)
add_public_tablegen_target(MLIRLoopSerializationPassIncGen)

add_mlir_doc(Passes LoopSerializationPasses ./ -gen-pass-doc)