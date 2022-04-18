// RUN: %target-build-swift %s

import Differentiation

public protocol RDAR84716758_Regression_Test_Layer: Differentiable {
  associatedtype Input: Differentiable
  associatedtype Output: Differentiable
  @differentiable(reverse, wrt: (self, input))
  @differentiable(reverse, wrt: input)
  func callAsFunction(_ input: Input) -> Output
}

public enum RDAR84716758_Regression_Test {
  // Test for explicitly declared `@differentiable` attributes.
  public class Function1<Input: Differentiable, Output: Differentiable>:
    RDAR84716758_Regression_Test_Layer
  {
    @noDerivative public let body: @differentiable(reverse) (Input) -> Output

    public init(_ body: @escaping @differentiable(reverse) (Input) -> Output) {
      self.body = body
    }

    @differentiable(reverse, wrt: (self, input))
    @differentiable(reverse, wrt: input)
    public func callAsFunction(_ input: Input) -> Output {
      body(input)
    }

    @differentiable(reverse, wrt: x where T: Differentiable)
    public func foo<T>(x: T) -> T {
      x
    }
  }

  // Test for implicitly generated `@differentiable` attributes.
  class Function2<Input: Differentiable, Output: Differentiable>:
    RDAR84716758_Regression_Test_Layer
  {
    @noDerivative let body: @differentiable(reverse) (Input) -> Output

    init(_ body: @escaping @differentiable(reverse) (Input) -> Output) {
      self.body = body
    }

    func callAsFunction(_ input: Input) -> Output {
      body(input)
    }
  }
}
