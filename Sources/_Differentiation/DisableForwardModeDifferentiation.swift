//===--- DisableForwardModeDifferentiation.swift --------------*- swift -*-===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2019 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//
//
// Exports a symbol that disables generation of JVP derivatives, which is
// required for compiling automatic differentiation code.
//
//===----------------------------------------------------------------------===//

import Swift

//===----------------------------------------------------------------------===//
// Diagnostics
//===----------------------------------------------------------------------===//

@_silgen_name("_fatalErrorForwardModeDifferentiationDisabled")
public func _fatalErrorForwardModeDifferentiationDisabled() -> Never {
  fatalError("""
    JVP does not exist. Use \
    '-Xfrontend -enable-experimental-forward-mode-differentiation' to enable \
    differential-first differentiation APIs.
    """)
}
