// RUN: %target-build-swift -g %s
// This test occaisionally fails to link.
// REQUIRES: SR14775

// TF-1232: IRGenDebugInfo crash due to lack of proper mangling for
// AutoDiff-generated declarations: linear map structs and branching trace
// enums.

import Differentiation

extension Float {
  @_silgen_name("tf1232_Regression_Test_add")
  static func tf1232_Regression_Test_add(_ x: Float, _ y: Float) -> Float {
    return x + y
  }

  @derivative(of: tf1232_Regression_Test_add)
  static func tf1232_Regression_Test_addVJP(_ x: Float, _ y: Float) -> (
    value: Float, pullback: (Float) -> (Float, Float)
  ) {
    return (tf1232_Regression_Test_add(x, y), { v in (v, v) })
  }
}

public enum TF1232_Regression_Test {
  @differentiable(reverse)
  func foo(_ x: Float) -> Float {
    let y = Float.tf1232_Regression_Test_add(x, x)
    return y
  }
}

// Failed to reconstruct type for $s4main42_AD__$s4main3fooyS2fF_bb0__PB__src_0_wrt_0VmD
// Original type:
// (metatype_type
//   (struct_type decl=main.(file)._AD__$s4main3fooyS2fF_bb0__PB__src_0_wrt_0))
// Assertion failed: (isa<X>(Val) && "cast<Ty>() argument of incompatible type!"), function cast, file /Users/danielzheng/swift-merge/llvm-project/llvm/include/llvm/Support/Casting.h, line 264.
