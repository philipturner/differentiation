//===--- FloatingPointDifferentiation.swift.gyb ---------------*- swift -*-===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2020 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import Swift
import SwiftShims


#if !os(macOS) && !(os(iOS) && targetEnvironment(macCatalyst))

//===----------------------------------------------------------------------===//
// Protocol conformances
//===----------------------------------------------------------------------===//

@available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
extension Float16: Differentiable {
  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
  public typealias TangentVector = Float16

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
  public mutating func move(by offset: TangentVector) {
    self += offset
  }
}

//===----------------------------------------------------------------------===//
// Derivatives
//===----------------------------------------------------------------------===//

/// Derivatives of standard unary operators.
@available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
extension Float16 {
  @usableFromInline
  @_transparent
  @derivative(of: -)
  static func _vjpNegate(x: Float16)
    -> (value: Float16, pullback: (Float16) -> Float16) {
    return (-x, { v in -v })
  }

  @usableFromInline
  @_transparent
  @derivative(of: -)
  static func _jvpNegate(x: Float16)
  -> (value: Float16, differential: (Float16) -> Float16) {
    return (-x, { dx in -dx })
  }
}

/// Derivatives of standard binary operators.
@available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
extension Float16 {
  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: +)
  static func _vjpAdd(
    lhs: Float16, rhs: Float16
  ) -> (value: Float16, pullback: (Float16) -> (Float16, Float16)) {
    return (lhs + rhs, { v in (v, v) })
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: +)
  static func _jvpAdd(
    lhs: Float16, rhs: Float16
  ) -> (value: Float16, differential: (Float16, Float16) -> Float16) {
    return (lhs + rhs, { (dlhs, drhs) in dlhs + drhs })
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: +=)
  static func _vjpAddAssign(_ lhs: inout Float16, _ rhs: Float16) -> (
    value: Void, pullback: (inout Float16) -> Float16
  ) {
    lhs += rhs
    return ((), { v in v })
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: +=)
  static func _jvpAddAssign(_ lhs: inout Float16, _ rhs: Float16) -> (
    value: Void, differential: (inout Float16, Float16) -> Void
  ) {
    lhs += rhs
    return ((), { $0 += $1 })
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: -)
  static func _vjpSubtract(
    lhs: Float16, rhs: Float16
  ) -> (value: Float16, pullback: (Float16) -> (Float16, Float16)) {
    return (lhs - rhs, { v in (v, -v) })
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: -)
  static func _jvpSubtract(
    lhs: Float16, rhs: Float16
  ) -> (value: Float16, differential: (Float16, Float16) -> Float16) {
    return (lhs - rhs, { (dlhs, drhs) in dlhs - drhs })
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: -=)
  static func _vjpSubtractAssign(_ lhs: inout Float16, _ rhs: Float16) -> (
    value: Void, pullback: (inout Float16) -> Float16
  ) {
    lhs -= rhs
    return ((), { v in -v })
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: -=)
  static func _jvpSubtractAssign(_ lhs: inout Float16, _ rhs: Float16) -> (
    value: Void, differential: (inout Float16, Float16) -> Void
  ) {
    lhs -= rhs
    return ((), { $0 -= $1 })
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: *)
  static func _vjpMultiply(
    lhs: Float16, rhs: Float16
  ) -> (value: Float16, pullback: (Float16) -> (Float16, Float16)) {
    return (lhs * rhs, { v in (rhs * v, lhs * v) })
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: *)
  static func _jvpMultiply(
    lhs: Float16, rhs: Float16
  ) -> (value: Float16, differential: (Float16, Float16) -> Float16) {
    return (lhs * rhs, { (dlhs, drhs) in lhs * drhs + rhs * dlhs })
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: *=)
  static func _vjpMultiplyAssign(_ lhs: inout Float16, _ rhs: Float16) -> (
    value: Void, pullback: (inout Float16) -> Float16
  ) {
    defer { lhs *= rhs }
    return ((), { [lhs = lhs] v in
      let drhs = lhs * v
      v *= rhs
      return drhs
    })
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: *=)
  static func _jvpMultiplyAssign(_ lhs: inout Float16, _ rhs: Float16) -> (
    value: Void, differential: (inout Float16, Float16) -> Void
  ) {
    let oldLhs = lhs
    lhs *= rhs
    return ((), { $0 = $0 * rhs + oldLhs * $1 })
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: /)
  static func _vjpDivide(
    lhs: Float16, rhs: Float16
  ) -> (value: Float16, pullback: (Float16) -> (Float16, Float16)) {
    return (lhs / rhs, { v in (v / rhs, -lhs / (rhs * rhs) * v) })
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: /)
  static func _jvpDivide(
    lhs: Float16, rhs: Float16
  ) -> (value: Float16, differential: (Float16, Float16) -> Float16) {
    return (lhs / rhs, { (dlhs, drhs) in dlhs / rhs - lhs / (rhs * rhs) * drhs })
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: /=)
  static func _vjpDivideAssign(_ lhs: inout Float16, _ rhs: Float16) -> (
    value: Void, pullback: (inout Float16) -> Float16
  ) {
    defer { lhs /= rhs }
    return ((), { [lhs = lhs] v in
      let drhs = -lhs / (rhs * rhs) * v
      v /= rhs
      return drhs
    })
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: /=)
  static func _jvpDivideAssign(_ lhs: inout Float16, _ rhs: Float16) -> (
    value: Void, differential: (inout Float16, Float16) -> Void
  ) {
    let oldLhs = lhs
    lhs /= rhs
    return ((), { $0 = ($0 * rhs - oldLhs * $1) / (rhs * rhs)  })
  }
}

#endif


//===----------------------------------------------------------------------===//
// Protocol conformances
//===----------------------------------------------------------------------===//


extension Float: Differentiable {
  
  public typealias TangentVector = Float

  
  public mutating func move(by offset: TangentVector) {
    self += offset
  }
}

//===----------------------------------------------------------------------===//
// Derivatives
//===----------------------------------------------------------------------===//

/// Derivatives of standard unary operators.

extension Float {
  @usableFromInline
  @_transparent
  @derivative(of: -)
  static func _vjpNegate(x: Float)
    -> (value: Float, pullback: (Float) -> Float) {
    return (-x, { v in -v })
  }

  @usableFromInline
  @_transparent
  @derivative(of: -)
  static func _jvpNegate(x: Float)
  -> (value: Float, differential: (Float) -> Float) {
    return (-x, { dx in -dx })
  }
}

/// Derivatives of standard binary operators.

extension Float {
  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: +)
  static func _vjpAdd(
    lhs: Float, rhs: Float
  ) -> (value: Float, pullback: (Float) -> (Float, Float)) {
    return (lhs + rhs, { v in (v, v) })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: +)
  static func _jvpAdd(
    lhs: Float, rhs: Float
  ) -> (value: Float, differential: (Float, Float) -> Float) {
    return (lhs + rhs, { (dlhs, drhs) in dlhs + drhs })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: +=)
  static func _vjpAddAssign(_ lhs: inout Float, _ rhs: Float) -> (
    value: Void, pullback: (inout Float) -> Float
  ) {
    lhs += rhs
    return ((), { v in v })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: +=)
  static func _jvpAddAssign(_ lhs: inout Float, _ rhs: Float) -> (
    value: Void, differential: (inout Float, Float) -> Void
  ) {
    lhs += rhs
    return ((), { $0 += $1 })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: -)
  static func _vjpSubtract(
    lhs: Float, rhs: Float
  ) -> (value: Float, pullback: (Float) -> (Float, Float)) {
    return (lhs - rhs, { v in (v, -v) })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: -)
  static func _jvpSubtract(
    lhs: Float, rhs: Float
  ) -> (value: Float, differential: (Float, Float) -> Float) {
    return (lhs - rhs, { (dlhs, drhs) in dlhs - drhs })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: -=)
  static func _vjpSubtractAssign(_ lhs: inout Float, _ rhs: Float) -> (
    value: Void, pullback: (inout Float) -> Float
  ) {
    lhs -= rhs
    return ((), { v in -v })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: -=)
  static func _jvpSubtractAssign(_ lhs: inout Float, _ rhs: Float) -> (
    value: Void, differential: (inout Float, Float) -> Void
  ) {
    lhs -= rhs
    return ((), { $0 -= $1 })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: *)
  static func _vjpMultiply(
    lhs: Float, rhs: Float
  ) -> (value: Float, pullback: (Float) -> (Float, Float)) {
    return (lhs * rhs, { v in (rhs * v, lhs * v) })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: *)
  static func _jvpMultiply(
    lhs: Float, rhs: Float
  ) -> (value: Float, differential: (Float, Float) -> Float) {
    return (lhs * rhs, { (dlhs, drhs) in lhs * drhs + rhs * dlhs })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: *=)
  static func _vjpMultiplyAssign(_ lhs: inout Float, _ rhs: Float) -> (
    value: Void, pullback: (inout Float) -> Float
  ) {
    defer { lhs *= rhs }
    return ((), { [lhs = lhs] v in
      let drhs = lhs * v
      v *= rhs
      return drhs
    })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: *=)
  static func _jvpMultiplyAssign(_ lhs: inout Float, _ rhs: Float) -> (
    value: Void, differential: (inout Float, Float) -> Void
  ) {
    let oldLhs = lhs
    lhs *= rhs
    return ((), { $0 = $0 * rhs + oldLhs * $1 })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: /)
  static func _vjpDivide(
    lhs: Float, rhs: Float
  ) -> (value: Float, pullback: (Float) -> (Float, Float)) {
    return (lhs / rhs, { v in (v / rhs, -lhs / (rhs * rhs) * v) })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: /)
  static func _jvpDivide(
    lhs: Float, rhs: Float
  ) -> (value: Float, differential: (Float, Float) -> Float) {
    return (lhs / rhs, { (dlhs, drhs) in dlhs / rhs - lhs / (rhs * rhs) * drhs })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: /=)
  static func _vjpDivideAssign(_ lhs: inout Float, _ rhs: Float) -> (
    value: Void, pullback: (inout Float) -> Float
  ) {
    defer { lhs /= rhs }
    return ((), { [lhs = lhs] v in
      let drhs = -lhs / (rhs * rhs) * v
      v /= rhs
      return drhs
    })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: /=)
  static func _jvpDivideAssign(_ lhs: inout Float, _ rhs: Float) -> (
    value: Void, differential: (inout Float, Float) -> Void
  ) {
    let oldLhs = lhs
    lhs /= rhs
    return ((), { $0 = ($0 * rhs - oldLhs * $1) / (rhs * rhs)  })
  }
}



//===----------------------------------------------------------------------===//
// Protocol conformances
//===----------------------------------------------------------------------===//


extension Double: Differentiable {
  
  public typealias TangentVector = Double

  
  public mutating func move(by offset: TangentVector) {
    self += offset
  }
}

//===----------------------------------------------------------------------===//
// Derivatives
//===----------------------------------------------------------------------===//

/// Derivatives of standard unary operators.

extension Double {
  @usableFromInline
  @_transparent
  @derivative(of: -)
  static func _vjpNegate(x: Double)
    -> (value: Double, pullback: (Double) -> Double) {
    return (-x, { v in -v })
  }

  @usableFromInline
  @_transparent
  @derivative(of: -)
  static func _jvpNegate(x: Double)
  -> (value: Double, differential: (Double) -> Double) {
    return (-x, { dx in -dx })
  }
}

/// Derivatives of standard binary operators.

extension Double {
  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: +)
  static func _vjpAdd(
    lhs: Double, rhs: Double
  ) -> (value: Double, pullback: (Double) -> (Double, Double)) {
    return (lhs + rhs, { v in (v, v) })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: +)
  static func _jvpAdd(
    lhs: Double, rhs: Double
  ) -> (value: Double, differential: (Double, Double) -> Double) {
    return (lhs + rhs, { (dlhs, drhs) in dlhs + drhs })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: +=)
  static func _vjpAddAssign(_ lhs: inout Double, _ rhs: Double) -> (
    value: Void, pullback: (inout Double) -> Double
  ) {
    lhs += rhs
    return ((), { v in v })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: +=)
  static func _jvpAddAssign(_ lhs: inout Double, _ rhs: Double) -> (
    value: Void, differential: (inout Double, Double) -> Void
  ) {
    lhs += rhs
    return ((), { $0 += $1 })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: -)
  static func _vjpSubtract(
    lhs: Double, rhs: Double
  ) -> (value: Double, pullback: (Double) -> (Double, Double)) {
    return (lhs - rhs, { v in (v, -v) })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: -)
  static func _jvpSubtract(
    lhs: Double, rhs: Double
  ) -> (value: Double, differential: (Double, Double) -> Double) {
    return (lhs - rhs, { (dlhs, drhs) in dlhs - drhs })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: -=)
  static func _vjpSubtractAssign(_ lhs: inout Double, _ rhs: Double) -> (
    value: Void, pullback: (inout Double) -> Double
  ) {
    lhs -= rhs
    return ((), { v in -v })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: -=)
  static func _jvpSubtractAssign(_ lhs: inout Double, _ rhs: Double) -> (
    value: Void, differential: (inout Double, Double) -> Void
  ) {
    lhs -= rhs
    return ((), { $0 -= $1 })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: *)
  static func _vjpMultiply(
    lhs: Double, rhs: Double
  ) -> (value: Double, pullback: (Double) -> (Double, Double)) {
    return (lhs * rhs, { v in (rhs * v, lhs * v) })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: *)
  static func _jvpMultiply(
    lhs: Double, rhs: Double
  ) -> (value: Double, differential: (Double, Double) -> Double) {
    return (lhs * rhs, { (dlhs, drhs) in lhs * drhs + rhs * dlhs })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: *=)
  static func _vjpMultiplyAssign(_ lhs: inout Double, _ rhs: Double) -> (
    value: Void, pullback: (inout Double) -> Double
  ) {
    defer { lhs *= rhs }
    return ((), { [lhs = lhs] v in
      let drhs = lhs * v
      v *= rhs
      return drhs
    })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: *=)
  static func _jvpMultiplyAssign(_ lhs: inout Double, _ rhs: Double) -> (
    value: Void, differential: (inout Double, Double) -> Void
  ) {
    let oldLhs = lhs
    lhs *= rhs
    return ((), { $0 = $0 * rhs + oldLhs * $1 })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: /)
  static func _vjpDivide(
    lhs: Double, rhs: Double
  ) -> (value: Double, pullback: (Double) -> (Double, Double)) {
    return (lhs / rhs, { v in (v / rhs, -lhs / (rhs * rhs) * v) })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: /)
  static func _jvpDivide(
    lhs: Double, rhs: Double
  ) -> (value: Double, differential: (Double, Double) -> Double) {
    return (lhs / rhs, { (dlhs, drhs) in dlhs / rhs - lhs / (rhs * rhs) * drhs })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: /=)
  static func _vjpDivideAssign(_ lhs: inout Double, _ rhs: Double) -> (
    value: Void, pullback: (inout Double) -> Double
  ) {
    defer { lhs /= rhs }
    return ((), { [lhs = lhs] v in
      let drhs = -lhs / (rhs * rhs) * v
      v /= rhs
      return drhs
    })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: /=)
  static func _jvpDivideAssign(_ lhs: inout Double, _ rhs: Double) -> (
    value: Void, differential: (inout Double, Double) -> Void
  ) {
    let oldLhs = lhs
    lhs /= rhs
    return ((), { $0 = ($0 * rhs - oldLhs * $1) / (rhs * rhs)  })
  }
}


#if !(os(Windows) || os(Android)) && (arch(i386) || arch(x86_64))

//===----------------------------------------------------------------------===//
// Protocol conformances
//===----------------------------------------------------------------------===//


extension Float80: Differentiable {
  
  public typealias TangentVector = Float80

  
  public mutating func move(by offset: TangentVector) {
    self += offset
  }
}

//===----------------------------------------------------------------------===//
// Derivatives
//===----------------------------------------------------------------------===//

/// Derivatives of standard unary operators.

extension Float80 {
  @usableFromInline
  @_transparent
  @derivative(of: -)
  static func _vjpNegate(x: Float80)
    -> (value: Float80, pullback: (Float80) -> Float80) {
    return (-x, { v in -v })
  }

  @usableFromInline
  @_transparent
  @derivative(of: -)
  static func _jvpNegate(x: Float80)
  -> (value: Float80, differential: (Float80) -> Float80) {
    return (-x, { dx in -dx })
  }
}

/// Derivatives of standard binary operators.

extension Float80 {
  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: +)
  static func _vjpAdd(
    lhs: Float80, rhs: Float80
  ) -> (value: Float80, pullback: (Float80) -> (Float80, Float80)) {
    return (lhs + rhs, { v in (v, v) })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: +)
  static func _jvpAdd(
    lhs: Float80, rhs: Float80
  ) -> (value: Float80, differential: (Float80, Float80) -> Float80) {
    return (lhs + rhs, { (dlhs, drhs) in dlhs + drhs })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: +=)
  static func _vjpAddAssign(_ lhs: inout Float80, _ rhs: Float80) -> (
    value: Void, pullback: (inout Float80) -> Float80
  ) {
    lhs += rhs
    return ((), { v in v })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: +=)
  static func _jvpAddAssign(_ lhs: inout Float80, _ rhs: Float80) -> (
    value: Void, differential: (inout Float80, Float80) -> Void
  ) {
    lhs += rhs
    return ((), { $0 += $1 })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: -)
  static func _vjpSubtract(
    lhs: Float80, rhs: Float80
  ) -> (value: Float80, pullback: (Float80) -> (Float80, Float80)) {
    return (lhs - rhs, { v in (v, -v) })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: -)
  static func _jvpSubtract(
    lhs: Float80, rhs: Float80
  ) -> (value: Float80, differential: (Float80, Float80) -> Float80) {
    return (lhs - rhs, { (dlhs, drhs) in dlhs - drhs })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: -=)
  static func _vjpSubtractAssign(_ lhs: inout Float80, _ rhs: Float80) -> (
    value: Void, pullback: (inout Float80) -> Float80
  ) {
    lhs -= rhs
    return ((), { v in -v })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: -=)
  static func _jvpSubtractAssign(_ lhs: inout Float80, _ rhs: Float80) -> (
    value: Void, differential: (inout Float80, Float80) -> Void
  ) {
    lhs -= rhs
    return ((), { $0 -= $1 })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: *)
  static func _vjpMultiply(
    lhs: Float80, rhs: Float80
  ) -> (value: Float80, pullback: (Float80) -> (Float80, Float80)) {
    return (lhs * rhs, { v in (rhs * v, lhs * v) })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: *)
  static func _jvpMultiply(
    lhs: Float80, rhs: Float80
  ) -> (value: Float80, differential: (Float80, Float80) -> Float80) {
    return (lhs * rhs, { (dlhs, drhs) in lhs * drhs + rhs * dlhs })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: *=)
  static func _vjpMultiplyAssign(_ lhs: inout Float80, _ rhs: Float80) -> (
    value: Void, pullback: (inout Float80) -> Float80
  ) {
    defer { lhs *= rhs }
    return ((), { [lhs = lhs] v in
      let drhs = lhs * v
      v *= rhs
      return drhs
    })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: *=)
  static func _jvpMultiplyAssign(_ lhs: inout Float80, _ rhs: Float80) -> (
    value: Void, differential: (inout Float80, Float80) -> Void
  ) {
    let oldLhs = lhs
    lhs *= rhs
    return ((), { $0 = $0 * rhs + oldLhs * $1 })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: /)
  static func _vjpDivide(
    lhs: Float80, rhs: Float80
  ) -> (value: Float80, pullback: (Float80) -> (Float80, Float80)) {
    return (lhs / rhs, { v in (v / rhs, -lhs / (rhs * rhs) * v) })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: /)
  static func _jvpDivide(
    lhs: Float80, rhs: Float80
  ) -> (value: Float80, differential: (Float80, Float80) -> Float80) {
    return (lhs / rhs, { (dlhs, drhs) in dlhs / rhs - lhs / (rhs * rhs) * drhs })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: /=)
  static func _vjpDivideAssign(_ lhs: inout Float80, _ rhs: Float80) -> (
    value: Void, pullback: (inout Float80) -> Float80
  ) {
    defer { lhs /= rhs }
    return ((), { [lhs = lhs] v in
      let drhs = -lhs / (rhs * rhs) * v
      v /= rhs
      return drhs
    })
  }

  
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @derivative(of: /=)
  static func _jvpDivideAssign(_ lhs: inout Float80, _ rhs: Float80) -> (
    value: Void, differential: (inout Float80, Float80) -> Void
  ) {
    let oldLhs = lhs
    lhs /= rhs
    return ((), { $0 = ($0 * rhs - oldLhs * $1) / (rhs * rhs)  })
  }
}

#endif

extension FloatingPoint
where
  Self: Differentiable,
  Self == Self.TangentVector
{
  @inlinable // FIXME(sil-serialize-all)
  @derivative(of: addingProduct)
  func _vjpAddingProduct(
    _ lhs: Self, _ rhs: Self
  ) -> (value: Self, pullback: (Self) -> (Self, Self, Self)) {
    return (addingProduct(lhs, rhs), { _ in (1, rhs, lhs) })
  }

  @inlinable // FIXME(sil-serialize-all)
  @derivative(of: squareRoot)
  func _vjpSquareRoot() -> (value: Self, pullback: (Self) -> Self) {
    let y = squareRoot()
    return (y, { v in v / (2 * y) })
  }

  @inlinable
  @derivative(of: minimum)
  static func _vjpMinimum(_ x: Self, _ y: Self) -> (
    value: Self, pullback: (TangentVector) -> (TangentVector, TangentVector)
  ) {
    if x <= y || y.isNaN { return (x, { v in (v, .zero) }) }
    return (y, { v in (.zero, v) })
  }

  @inlinable
  @derivative(of: maximum)
  static func _vjpMaximum(_ x: Self, _ y: Self) -> (
    value: Self, pullback: (TangentVector) -> (TangentVector, TangentVector)
  ) {
    if x > y || y.isNaN { return (x, { v in (v, .zero) }) }
    return (y, { v in (.zero, v) })
  }
}
