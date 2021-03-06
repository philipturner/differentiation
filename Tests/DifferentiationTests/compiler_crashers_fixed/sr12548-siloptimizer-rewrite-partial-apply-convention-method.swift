// RUN: %target-build-swift -O %s

// SR-12548: SIL verification error regarding
// `CapturePropagation::rewritePartialApply` for `partial_apply` with
// `@convention(method)` callee.

import Differentiation

protocol SR12548_Protocol: Differentiable {
  @differentiable(reverse)
  func method() -> Self
}

extension SR12548_Protocol {
  @differentiable(reverse)
  func method() -> Self { self }
}

extension DifferentiationTests {
  func testSR12548() throws {
    struct Struct: SR12548_Protocol {}
    let transformed:
      @differentiable(reverse) (Struct) -> Struct = { $0.method() }
  }
}

// SIL verification failed: operand of thin_to_thick_function must be thin: opFTy->getRepresentation() == SILFunctionType::Representation::Thin
// Verifying instruction:
//      // function_ref specialized Protocol.method()
//   %5 = function_ref @$s7crasher8ProtocolPAAE6methodxyFAA6StructV_TG5 : $@convention(method) (@in_guaranteed Struct) -> @out Struct // user: %6
// ->   %6 = thin_to_thick_function %5 : $@convention(method) (@in_guaranteed Struct) -> @out Struct to $@callee_guaranteed (@in_guaranteed Struct) -> @out Struct // user: %11
