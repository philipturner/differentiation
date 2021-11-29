//
//  DisableForwardModeDifferentiation.swift
//  
//
//  Created by Philip Turner on 11/29/21.
//

import Swift

@_silgen_name("_fatalErrorForwardModeDifferentiationDisabled")
public func _fatalErrorForwardModeDifferentiationDisabled() -> Never {
  fatalError("""
    JVP does not exist. Use \
    '-Xfrontend -enable-experimental-forward-mode-differentiation' to enable \
    differential-first differentiation APIs.
    """)
}
