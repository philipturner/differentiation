#sourceLocation(file: "../gyb-sources/SIMDDifferentiation.swift.gyb", line: 1)
//===--- SIMDDifferentiation.swift.gyb ------------------------*- swift -*-===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2019 - 2020 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import Swift

#sourceLocation(file: "../gyb-sources/SIMDDifferentiation.swift.gyb", line: 19)

#sourceLocation(file: "../gyb-sources/SIMDDifferentiation.swift.gyb", line: 21)

//===----------------------------------------------------------------------===//
// Protocol conformances
//===----------------------------------------------------------------------===//

extension SIMD2: AdditiveArithmetic where Scalar: FloatingPoint {}

extension SIMD2: Differentiable
where
  Scalar: Differentiable & BinaryFloatingPoint,
  Scalar.TangentVector: BinaryFloatingPoint
{
  public typealias TangentVector = SIMD2
}

//===----------------------------------------------------------------------===//
// Derivatives
//===----------------------------------------------------------------------===//

extension SIMD2
where
  Scalar: Differentiable & BinaryFloatingPoint,
  Scalar.TangentVector == Scalar
{
  // NOTE(TF-1094): serialized `@derivative` for `.swiftinterface` compilation.
  @inlinable
  @derivative(of: subscript(_:))
  internal func _vjpSubscript(_ index: Int)
    -> (value: Scalar, pullback: (Scalar.TangentVector) -> TangentVector)
  {
    return (self[index], { v in
      var zeros = Self.zero
      zeros[index] = v
      return zeros
    })
  }

  @inlinable
  @derivative(of: subscript(_:))
  internal func _jvpSubscript(index: Int)
    -> (value: Scalar, differential: (TangentVector) -> Scalar.TangentVector)
  {
    return (self[index], { v in
      return .init(v[index])
    })
  }

  @inlinable
  @derivative(of: subscript(_:).set)
  internal mutating func _vjpSubscriptSetter(_ newValue: Scalar, _ index: Int)
    -> (value: Void, pullback: (inout TangentVector) -> Scalar.TangentVector)
  {
    self[index] = newValue
    return ((), { dSelf in
      let dNewValue = dSelf[index]
      dSelf[index] = 0
      return dNewValue
    })
  }
}

#sourceLocation(file: "../gyb-sources/SIMDDifferentiation.swift.gyb", line: 21)

//===----------------------------------------------------------------------===//
// Protocol conformances
//===----------------------------------------------------------------------===//

extension SIMD4: AdditiveArithmetic where Scalar: FloatingPoint {}

extension SIMD4: Differentiable
where
  Scalar: Differentiable & BinaryFloatingPoint,
  Scalar.TangentVector: BinaryFloatingPoint
{
  public typealias TangentVector = SIMD4
}

//===----------------------------------------------------------------------===//
// Derivatives
//===----------------------------------------------------------------------===//

extension SIMD4
where
  Scalar: Differentiable & BinaryFloatingPoint,
  Scalar.TangentVector == Scalar
{
  // NOTE(TF-1094): serialized `@derivative` for `.swiftinterface` compilation.
  @inlinable
  @derivative(of: subscript(_:))
  internal func _vjpSubscript(_ index: Int)
    -> (value: Scalar, pullback: (Scalar.TangentVector) -> TangentVector)
  {
    return (self[index], { v in
      var zeros = Self.zero
      zeros[index] = v
      return zeros
    })
  }

  @inlinable
  @derivative(of: subscript(_:))
  internal func _jvpSubscript(index: Int)
    -> (value: Scalar, differential: (TangentVector) -> Scalar.TangentVector)
  {
    return (self[index], { v in
      return .init(v[index])
    })
  }

  @inlinable
  @derivative(of: subscript(_:).set)
  internal mutating func _vjpSubscriptSetter(_ newValue: Scalar, _ index: Int)
    -> (value: Void, pullback: (inout TangentVector) -> Scalar.TangentVector)
  {
    self[index] = newValue
    return ((), { dSelf in
      let dNewValue = dSelf[index]
      dSelf[index] = 0
      return dNewValue
    })
  }
}

#sourceLocation(file: "../gyb-sources/SIMDDifferentiation.swift.gyb", line: 21)

//===----------------------------------------------------------------------===//
// Protocol conformances
//===----------------------------------------------------------------------===//

extension SIMD8: AdditiveArithmetic where Scalar: FloatingPoint {}

extension SIMD8: Differentiable
where
  Scalar: Differentiable & BinaryFloatingPoint,
  Scalar.TangentVector: BinaryFloatingPoint
{
  public typealias TangentVector = SIMD8
}

//===----------------------------------------------------------------------===//
// Derivatives
//===----------------------------------------------------------------------===//

extension SIMD8
where
  Scalar: Differentiable & BinaryFloatingPoint,
  Scalar.TangentVector == Scalar
{
  // NOTE(TF-1094): serialized `@derivative` for `.swiftinterface` compilation.
  @inlinable
  @derivative(of: subscript(_:))
  internal func _vjpSubscript(_ index: Int)
    -> (value: Scalar, pullback: (Scalar.TangentVector) -> TangentVector)
  {
    return (self[index], { v in
      var zeros = Self.zero
      zeros[index] = v
      return zeros
    })
  }

  @inlinable
  @derivative(of: subscript(_:))
  internal func _jvpSubscript(index: Int)
    -> (value: Scalar, differential: (TangentVector) -> Scalar.TangentVector)
  {
    return (self[index], { v in
      return .init(v[index])
    })
  }

  @inlinable
  @derivative(of: subscript(_:).set)
  internal mutating func _vjpSubscriptSetter(_ newValue: Scalar, _ index: Int)
    -> (value: Void, pullback: (inout TangentVector) -> Scalar.TangentVector)
  {
    self[index] = newValue
    return ((), { dSelf in
      let dNewValue = dSelf[index]
      dSelf[index] = 0
      return dNewValue
    })
  }
}

#sourceLocation(file: "../gyb-sources/SIMDDifferentiation.swift.gyb", line: 21)

//===----------------------------------------------------------------------===//
// Protocol conformances
//===----------------------------------------------------------------------===//

extension SIMD16: AdditiveArithmetic where Scalar: FloatingPoint {}

extension SIMD16: Differentiable
where
  Scalar: Differentiable & BinaryFloatingPoint,
  Scalar.TangentVector: BinaryFloatingPoint
{
  public typealias TangentVector = SIMD16
}

//===----------------------------------------------------------------------===//
// Derivatives
//===----------------------------------------------------------------------===//

extension SIMD16
where
  Scalar: Differentiable & BinaryFloatingPoint,
  Scalar.TangentVector == Scalar
{
  // NOTE(TF-1094): serialized `@derivative` for `.swiftinterface` compilation.
  @inlinable
  @derivative(of: subscript(_:))
  internal func _vjpSubscript(_ index: Int)
    -> (value: Scalar, pullback: (Scalar.TangentVector) -> TangentVector)
  {
    return (self[index], { v in
      var zeros = Self.zero
      zeros[index] = v
      return zeros
    })
  }

  @inlinable
  @derivative(of: subscript(_:))
  internal func _jvpSubscript(index: Int)
    -> (value: Scalar, differential: (TangentVector) -> Scalar.TangentVector)
  {
    return (self[index], { v in
      return .init(v[index])
    })
  }

  @inlinable
  @derivative(of: subscript(_:).set)
  internal mutating func _vjpSubscriptSetter(_ newValue: Scalar, _ index: Int)
    -> (value: Void, pullback: (inout TangentVector) -> Scalar.TangentVector)
  {
    self[index] = newValue
    return ((), { dSelf in
      let dNewValue = dSelf[index]
      dSelf[index] = 0
      return dNewValue
    })
  }
}

#sourceLocation(file: "../gyb-sources/SIMDDifferentiation.swift.gyb", line: 21)

//===----------------------------------------------------------------------===//
// Protocol conformances
//===----------------------------------------------------------------------===//

extension SIMD32: AdditiveArithmetic where Scalar: FloatingPoint {}

extension SIMD32: Differentiable
where
  Scalar: Differentiable & BinaryFloatingPoint,
  Scalar.TangentVector: BinaryFloatingPoint
{
  public typealias TangentVector = SIMD32
}

//===----------------------------------------------------------------------===//
// Derivatives
//===----------------------------------------------------------------------===//

extension SIMD32
where
  Scalar: Differentiable & BinaryFloatingPoint,
  Scalar.TangentVector == Scalar
{
  // NOTE(TF-1094): serialized `@derivative` for `.swiftinterface` compilation.
  @inlinable
  @derivative(of: subscript(_:))
  internal func _vjpSubscript(_ index: Int)
    -> (value: Scalar, pullback: (Scalar.TangentVector) -> TangentVector)
  {
    return (self[index], { v in
      var zeros = Self.zero
      zeros[index] = v
      return zeros
    })
  }

  @inlinable
  @derivative(of: subscript(_:))
  internal func _jvpSubscript(index: Int)
    -> (value: Scalar, differential: (TangentVector) -> Scalar.TangentVector)
  {
    return (self[index], { v in
      return .init(v[index])
    })
  }

  @inlinable
  @derivative(of: subscript(_:).set)
  internal mutating func _vjpSubscriptSetter(_ newValue: Scalar, _ index: Int)
    -> (value: Void, pullback: (inout TangentVector) -> Scalar.TangentVector)
  {
    self[index] = newValue
    return ((), { dSelf in
      let dNewValue = dSelf[index]
      dSelf[index] = 0
      return dNewValue
    })
  }
}

#sourceLocation(file: "../gyb-sources/SIMDDifferentiation.swift.gyb", line: 21)

//===----------------------------------------------------------------------===//
// Protocol conformances
//===----------------------------------------------------------------------===//

extension SIMD64: AdditiveArithmetic where Scalar: FloatingPoint {}

extension SIMD64: Differentiable
where
  Scalar: Differentiable & BinaryFloatingPoint,
  Scalar.TangentVector: BinaryFloatingPoint
{
  public typealias TangentVector = SIMD64
}

//===----------------------------------------------------------------------===//
// Derivatives
//===----------------------------------------------------------------------===//

extension SIMD64
where
  Scalar: Differentiable & BinaryFloatingPoint,
  Scalar.TangentVector == Scalar
{
  // NOTE(TF-1094): serialized `@derivative` for `.swiftinterface` compilation.
  @inlinable
  @derivative(of: subscript(_:))
  internal func _vjpSubscript(_ index: Int)
    -> (value: Scalar, pullback: (Scalar.TangentVector) -> TangentVector)
  {
    return (self[index], { v in
      var zeros = Self.zero
      zeros[index] = v
      return zeros
    })
  }

  @inlinable
  @derivative(of: subscript(_:))
  internal func _jvpSubscript(index: Int)
    -> (value: Scalar, differential: (TangentVector) -> Scalar.TangentVector)
  {
    return (self[index], { v in
      return .init(v[index])
    })
  }

  @inlinable
  @derivative(of: subscript(_:).set)
  internal mutating func _vjpSubscriptSetter(_ newValue: Scalar, _ index: Int)
    -> (value: Void, pullback: (inout TangentVector) -> Scalar.TangentVector)
  {
    self[index] = newValue
    return ((), { dSelf in
      let dNewValue = dSelf[index]
      dSelf[index] = 0
      return dNewValue
    })
  }
}

#sourceLocation(file: "../gyb-sources/SIMDDifferentiation.swift.gyb", line: 21)

//===----------------------------------------------------------------------===//
// Protocol conformances
//===----------------------------------------------------------------------===//

extension SIMD3: AdditiveArithmetic where Scalar: FloatingPoint {}

extension SIMD3: Differentiable
where
  Scalar: Differentiable & BinaryFloatingPoint,
  Scalar.TangentVector: BinaryFloatingPoint
{
  public typealias TangentVector = SIMD3
}

//===----------------------------------------------------------------------===//
// Derivatives
//===----------------------------------------------------------------------===//

extension SIMD3
where
  Scalar: Differentiable & BinaryFloatingPoint,
  Scalar.TangentVector == Scalar
{
  // NOTE(TF-1094): serialized `@derivative` for `.swiftinterface` compilation.
  @inlinable
  @derivative(of: subscript(_:))
  internal func _vjpSubscript(_ index: Int)
    -> (value: Scalar, pullback: (Scalar.TangentVector) -> TangentVector)
  {
    return (self[index], { v in
      var zeros = Self.zero
      zeros[index] = v
      return zeros
    })
  }

  @inlinable
  @derivative(of: subscript(_:))
  internal func _jvpSubscript(index: Int)
    -> (value: Scalar, differential: (TangentVector) -> Scalar.TangentVector)
  {
    return (self[index], { v in
      return .init(v[index])
    })
  }

  @inlinable
  @derivative(of: subscript(_:).set)
  internal mutating func _vjpSubscriptSetter(_ newValue: Scalar, _ index: Int)
    -> (value: Void, pullback: (inout TangentVector) -> Scalar.TangentVector)
  {
    self[index] = newValue
    return ((), { dSelf in
      let dNewValue = dSelf[index]
      dSelf[index] = 0
      return dNewValue
    })
  }
}

#sourceLocation(file: "../gyb-sources/SIMDDifferentiation.swift.gyb", line: 83)

extension SIMD
where
  Self: Differentiable,
  TangentVector: SIMD,
  Scalar: BinaryFloatingPoint,
  TangentVector.Scalar: BinaryFloatingPoint
{
  @inlinable
  @derivative(of: +)
  static func _vjpAdd(lhs: Self, rhs: Self)
    -> (
      value: Self, pullback: (TangentVector) -> (TangentVector, TangentVector)
    )
  {
    return (lhs + rhs, { v in
      return (v, v)
    })
  }

  @inlinable
  @derivative(of: +)
  static func _jvpAdd(lhs: Self, rhs: Self)
    -> (
      value: Self, differential: (TangentVector, TangentVector) -> TangentVector
    )
  {
    return (lhs + rhs, { ltan, rtan in
      return ltan + rtan
    })
  }

  @inlinable
  @derivative(of: -)
  static func _vjpSubtract(lhs: Self, rhs: Self)
    -> (
      value: Self, pullback: (TangentVector) -> (TangentVector, TangentVector)
    )
  {
    return (lhs - rhs, { v in
      return (v, -v)
    })
  }

  @inlinable
  @derivative(of: -)
  static func _jvpSubtract(lhs: Self, rhs: Self)
    -> (
      value: Self, differential: (TangentVector, TangentVector) -> TangentVector
    )
  {
    return (lhs - rhs, { ltan, rtan in
      return ltan - rtan
    })
  }

  @inlinable
  @derivative(of: -)
  static func _vjpNegate(rhs: Self)
    -> (value: Self, pullback: (TangentVector) -> (TangentVector))
  {
    return (-rhs, { v in
      return -v
    })
  }

  @inlinable
  @derivative(of: -)
  static func _jvpNegate(rhs: Self)
    -> (value: Self, differential: (TangentVector) -> (TangentVector))
  {
    return (-rhs, { v in
      return -v
    })
  }
}

extension SIMD
where
  Self: Differentiable,
  Scalar: BinaryFloatingPoint,
  Self.TangentVector == Self
{
  @inlinable
  @derivative(of: *)
  static func _vjpMultiply(lhs: Self, rhs: Self)
    -> (
      value: Self, pullback: (TangentVector) -> (TangentVector, TangentVector)
    )
  {
    return (lhs * rhs, { v in
      return (v * rhs, v * lhs)
    })
  }

  @inlinable
  @derivative(of: *)
  static func _jvpMultiply(lhs: Self, rhs: Self)
    -> (
      value: Self,  differential: (TangentVector, TangentVector) -> TangentVector
    )
  {
    return (lhs * rhs, { ltan, rtan in
      return lhs * rtan + ltan * rhs
    })
  }

  @inlinable
  @derivative(of: /)
  static func _vjpDivide(lhs: Self, rhs: Self)
    -> (
      value: Self, pullback: (TangentVector) -> (TangentVector, TangentVector)
    )
  {
    return ( lhs / rhs, { v in
      (v / rhs, -lhs / (rhs * rhs) * v)
    })
  }

  @inlinable
  @derivative(of: /)
  static func _jvpDivide(lhs: Self, rhs: Self)
    -> (
      value: Self, differential: (TangentVector, TangentVector) -> TangentVector
    )
  {
    return ( lhs / rhs, { ltan, rtan in
      (ltan * rhs - lhs * rtan) / (rhs * rhs)
    })
  }
}

extension SIMD
where
  Self: Differentiable,
  TangentVector: SIMD,
  Scalar: BinaryFloatingPoint & Differentiable,
  Scalar.TangentVector: BinaryFloatingPoint,
  TangentVector.Scalar == Scalar.TangentVector
{
  @inlinable
  @derivative(of: +)
  static func _vjpAdd(lhs: Scalar, rhs: Self) -> (
    value: Self,
    pullback: (TangentVector) -> (Scalar.TangentVector, TangentVector)
  ) {
    return (lhs + rhs, { v in
      return (v.sum(), v)
    })
  }

  @inlinable
  @derivative(of: +)
  static func _jvpAdd(lhs: Scalar, rhs: Self) -> (
    value: Self,
    differential: (Scalar.TangentVector, TangentVector) -> TangentVector
  ) {
    return (lhs + rhs, { ltan, rtan in
      return ltan + rtan
    })
  }

  @inlinable
  @derivative(of: -)
  static func _vjpSubtract(lhs: Scalar, rhs: Self) -> (
    value: Self,
    pullback: (TangentVector) -> (Scalar.TangentVector, TangentVector)
  ) {
    return (lhs - rhs, { v in
      return (v.sum(), -v)
    })
  }

  @inlinable
  @derivative(of: -)
  static func _jvpSubtract(lhs: Scalar, rhs: Self) -> (
    value: Self,
    differential: (Scalar.TangentVector, TangentVector) -> TangentVector
  ) {
    return (lhs - rhs, { ltan, rtan in
      return ltan - rtan
    })
  }

  @inlinable
  @derivative(of: +)
  static func _vjpAdd(lhs: Self, rhs: Scalar) -> (
    value: Self,
    pullback: (TangentVector) -> (TangentVector, Scalar.TangentVector)
  ) {
    return (lhs + rhs, { v in
      return (v, v.sum())
    })
  }

  @inlinable
  @derivative(of: +)
  static func _jvpAdd(lhs: Self, rhs: Scalar) -> (
    value: Self,
    differential: (TangentVector, Scalar.TangentVector) -> TangentVector
  ) {
    return (lhs + rhs, { ltan, rtan in
      return ltan + rtan
    })
  }

  @inlinable
  @derivative(of: -)
  static func _vjpSubtract(lhs: Self, rhs: Scalar) -> (
    value: Self,
    pullback: (TangentVector) -> (TangentVector, Scalar.TangentVector)
  ) {
    return (lhs - rhs, { v in
      return (v, -v.sum())
    })
  }

  @inlinable
  @derivative(of: -)
  static func _jvpSubtract(lhs: Self, rhs: Scalar) -> (
    value: Self,
    differential: (TangentVector, Scalar.TangentVector) -> TangentVector
  ) {
    return (lhs - rhs, { ltan, rtan in
      return ltan - rtan
    })
  }
}

extension SIMD
where
  Self: Differentiable,
  Scalar: BinaryFloatingPoint & Differentiable,
  Self.TangentVector == Self,
  Scalar.TangentVector == Scalar
{
  @inlinable
  @derivative(of: *)
  static func _vjpMultiply(lhs: Self, rhs: Scalar) -> (
    value: Self,
    pullback: (TangentVector) -> (TangentVector, Scalar.TangentVector)
  ) {
    return (lhs * rhs, { v in
      return (v * rhs, (v * lhs).sum())
    })
  }

  @inlinable
  @derivative(of: *)
  static func _jvpMultiply(lhs: Self, rhs: Scalar) -> (
    value: Self,
    differential: (TangentVector, Scalar.TangentVector) -> TangentVector
  ) {
    return (lhs * rhs, { ltan, rtan in
      return lhs * rtan + ltan * rhs
    })
  }

  @inlinable
  @derivative(of: /)
  static func _vjpDivide(lhs: Self, rhs: Scalar) -> (
    value: Self,
    pullback: (TangentVector) -> (TangentVector, Scalar.TangentVector)
  ) {
    return (lhs / rhs, { v in
      (v / rhs, (-lhs / (rhs * rhs) * v).sum())
    })
  }

  @inlinable
  @derivative(of: /)
  static func _jvpDivide(lhs: Self, rhs: Scalar) -> (
    value: Self,
    differential: (TangentVector, Scalar.TangentVector) -> TangentVector
  ) {
    return (lhs / rhs, { ltan, rtan in
      (ltan * rhs - lhs * rtan) / (rhs * rhs)
    })
  }

  @inlinable
  @derivative(of: *)
  static func _vjpMultiply(lhs: Scalar, rhs: Self) -> (
    value: Self,
    pullback: (TangentVector) -> (Scalar.TangentVector, TangentVector)
  ) {
    return (lhs * rhs, { v in
      return ((v * rhs).sum(), v * lhs)
    })
  }

  @inlinable
  @derivative(of: *)
  static func _jvpMultiply(lhs: Scalar, rhs: Self) -> (
    value: Self,
    differential: (Scalar.TangentVector, TangentVector) -> TangentVector
  ) {
    return (lhs * rhs, { ltan, rtan in
      return lhs * rtan + ltan * rhs
    })
  }

  @inlinable
  @derivative(of: /)
  static func _vjpDivide(lhs: Scalar, rhs: Self) -> (
    value: Self,
    pullback: (TangentVector) -> (Scalar.TangentVector, TangentVector)
  ) {
    return (lhs / rhs, { v in
      ((v / rhs).sum(), -lhs / (rhs * rhs) * v)
    })
  }

  @inlinable
  @derivative(of: /)
  static func _jvpDivide(lhs: Scalar, rhs: Self) -> (
    value: Self,
    differential: (Scalar.TangentVector, TangentVector) -> TangentVector
  ) {
    return (lhs / rhs, { ltan, rtan in
      (ltan * rhs - lhs * rtan) / (rhs * rhs)
    })
  }
}

// FIXME(TF-1103): Derivative registration does not yet support
// `@_alwaysEmitIntoClient` original functions like `SIMD.sum()`.
/*
extension SIMD
where
  Self: Differentiable,
  TangentVector: SIMD,
  Scalar: BinaryFloatingPoint & Differentiable,
  Scalar.TangentVector: BinaryFloatingPoint,
  TangentVector == Self
{
  @inlinable
  @derivative(of: sum)
  func _vjpSum() -> (
    value: Scalar, pullback: (Scalar.TangentVector) -> TangentVector
  ) {
    return (sum(), { v in Self(repeating: Scalar(v)) })
  }

  @inlinable
  @derivative(of: sum)
  func _jvpSum() -> (
    value: Scalar, differential: (TangentVector) -> Scalar.TangentVector
  ) {
    return (sum(), { v in Scalar.TangentVector(v.sum()) })
  }
}
*/

extension SIMD
where
  Self: Differentiable,
  Scalar: BinaryFloatingPoint & Differentiable,
  Self.TangentVector == Self,
  Scalar.TangentVector == Scalar
{
  @inlinable
  @derivative(of: init(repeating:))
  static func _vjpInit(repeating value: Scalar)
    -> (value: Self, pullback: (TangentVector) -> Scalar.TangentVector)
  {
    return (Self(repeating: value), { v in v.sum() })
  }

  @inlinable
  @derivative(of: init(repeating:))
  static func _jvpInit(repeating value: Scalar)
    -> (value: Self, differential: (Scalar.TangentVector) -> TangentVector)
  {
    return (Self(repeating: value), { v in Self(repeating: v) })
  }
}
