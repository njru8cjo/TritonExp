get_property(dialect_libs GLOBAL PROPERTY MLIR_DIALECT_LIBS)
get_property(conversion_libs GLOBAL PROPERTY MLIR_CONVERSION_LIBS)
set(LIBS
        ${dialect_libs}
        ${conversion_libs}
        MLIROptLib
		MLIRLoopSerializationTransforms
        )
add_llvm_executable(loopSerialization loopSerialization.cpp)

install(TARGETS loopSerialization
EXPORT LoopSerializationTargets
RUNTIME DESTINATION ${LLVM_TOOLS_INSTALL_DIR}
COMPONENT loopSerialization)

llvm_update_compile_flags(loopSerialization)
target_link_libraries(loopSerialization PRIVATE ${LIBS})
