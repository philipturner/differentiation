// RUN: %target-build-swift %s
// RUN: %target-swift-frontend -c -g -Xllvm -verify-di-holes=true %s

// rdar://74876596 ([SR-14290]: SIL verification fails when differentiating a function of [[Double]])

import Differentiation

extension DifferentiationTests {
  func testSR14290() throws {
    let values: [[Double]] = [[0, 0], [0, 0]]
    let const = 1.12345
    let result = add(const, to: values)

    @differentiable(reverse)
    func add(_ const: Double, to values: [[Double]]) -> [[Double]] {
        var result = values
        for i in withoutDerivative(at: values.indices) {
            for j in withoutDerivative(at: values.indices) {
                result.SR14290_Regression_Test_updated(
                  at: i, j, with: values[i][j] + const)
            }
        }
        return result
    }
  }
}

extension Array where Element == [Double] {
    @differentiable(reverse)
    mutating func SR14290_Regression_Test_updated(
      at i: Int, _ j: Int, with newValue: Double
    ) {
        self[i][j] = newValue
    }

    @derivative(of: SR14290_Regression_Test_updated)
    mutating func SR14290_Regression_Test_vjpUpdated(
      at i: Int, _ j: Int, with newValue: Double
    ) -> (
      value: Void, pullback: (inout TangentVector) -> (Double.TangentVector)
    ) {
        self.SR14290_Regression_Test_updated(at: i, j, with: newValue)

        func pullback(dSelf: inout TangentVector) -> (Double.TangentVector) {
            let dElement = dSelf[i][j]
            dSelf.base[i].base[j] = 0
            return dElement
        }
        let value: Void = ()

        return (value, pullback)
    }
}
