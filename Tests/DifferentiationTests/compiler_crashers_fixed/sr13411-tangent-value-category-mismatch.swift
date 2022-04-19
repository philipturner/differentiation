// RUN: %target-build-swift %s

// SR-13411: Semantic member getter pullback generation crash due to tangent value category mismatch

import Differentiation

public enum SR13411_Regression_Test {
  struct Dense: Differentiable {
    @differentiable(reverse)
    var bias: Float?
  }
}
