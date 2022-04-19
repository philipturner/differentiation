// RUN: %target-run-simple-swift

// REQUIRES: executable_test

// SR-14240: Error: symbol 'powTJfSSpSr' (powTJfSSpSr) is in generated IR file,
// but not in TBD file.

import Differentiation

#if canImport(Darwin)
  import Darwin
#elseif canImport(Glibc)
  import Glibc
#elseif os(Windows)
  import CRT
#else
#error("Unsupported platform")
#endif

public enum SR14240_Regression_Test {
  static func _pow(_ base: Double, _ exponent: Double) -> Double {
    pow(base, exponent)
  }
  
  @inlinable
  @derivative(of: _pow)
  static func _powVJP(
    _ base: Double, _ exponent: Double
  ) -> (value: Double, pullback: (Double) -> (Double, Double)) {
    fatalError()
  }
}
