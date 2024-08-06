#ifndef LOOP_SERIALIZATION_PASSES_H
#define LOOP_SERIALIZATION_PASSES_H

#include "mlir/Pass/Pass.h"
//#include <memory>

namespace mlir {
namespace loopSerialization {
std::unique_ptr<Pass> createLoopSerializationPass();
// Already specified constructor
/*
#define GEN_PASS_DECL
#include "Passes.h.inc"
*/
} // namespace loopSerialization

namespace scf {
class SCFDialect;
} // namespace scf

#define GEN_PASS_REGISTRATION
#include "Passes.h.inc"

} // namespace mlir

#endif // LOOP_SERIALIZATION_PASSES_H
