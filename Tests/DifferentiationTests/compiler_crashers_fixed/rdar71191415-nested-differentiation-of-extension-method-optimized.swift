// RUN: %target-build-swift -O %s

// FIXME(rdar://89055298)
// UNSUPPORTED: linux

// rdar://71191415

import Differentiation

protocol RDAR71191415_Regression_Test_P {
  @differentiable(reverse)
  func req(_ input: Float) -> Float
}

extension RDAR71191415_Regression_Test_P {
  @differentiable(reverse)
  func foo(_ input: Float) -> Float {
    return req(input)
  }
}

public enum RDAR71191415_Regression_Test {
  struct Dummy: RDAR71191415_Regression_Test_P {
    @differentiable(reverse)
    func req(_ input: Float) -> Float {
      input
    }
  }

  struct DummyComposition: RDAR71191415_Regression_Test_P {
    var layer = Dummy()

    @differentiable(reverse)
    func req(_ input: Float) -> Float {
      layer.foo(input)
    }
  }
}
