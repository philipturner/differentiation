// RUN: %target-swift-frontend -typecheck -verify %s

// SR-12642: Crash regarding `Differentiable` derived conformances and
// redeclared properties. This crash surfaced only briefly during the
// implementation of wrapped property differentiation (SR-12637).

import Differentiation

struct SR12642_Regression_Test_Generic<T> {}
extension SR12642_Regression_Test_Generic: Differentiable
where T: Differentiable {}

public enum SR12642_Regression_Test {
  @propertyWrapper
  struct Wrapper<Value> {
    var wrappedValue: Value
  }

  struct WrappedProperties: Differentiable {
    @Wrapper var int: SR12642_Regression_Test_Generic<Int>
    // expected-note@-1 {{'int' previously declared here}}
    // expected-note@-2 {{'_int' synthesized for property wrapper backing storage}}
    // expected-warning@-3 {{stored property 'int' has no derivative because 'Generic<Int>' does not conform to 'Differentiable'; add an explicit '@noDerivative' attribute}}

    @Wrapper var int: SR12642_Regression_Test_Generic<Int>
    // expected-error@-1 {{invalid redeclaration of 'int'}}
    // expected-error@-2 {{invalid redeclaration of synthesized property '_int'}}
  }
}
