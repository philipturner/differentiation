# Differentiation

A workaround for enabling differentiation in Swift until the standard library officially supports it. This is not needed in Swift development builds, and it may not reflect the most recent commits to the standard library.

> Warning: Swift's current implementation of differentiation is still experimental. Bug fixes implemented in development toolchains may take weeks to integrate into release toolchains.

## How to Use

```swift
import Differentiation

struct Example: Differentiable {
    var x: Float
}

@differentiable(reverse)
func foo(x: Float) -> Float {
    ...
}
```

## Demonstration

This package was been used in an iOS [sample project](https://github.com/philipturner/differentiation-ios-demo) to find velocity from physics equations.

## How to Maintain

To synchronize this package with the code in the [apple/swift](https://github.com/apple/swift) repository, follow these steps:
1. Locate [swift/stdlib/public/Differentiation](https://github.com/apple/swift/tree/main/stdlib/public/Differentiation) in the Swift GitHub repository.
2. Copy files ending with `.gyb` into "Sources/gyb-sources".
3. Copy all other Swift files into their counterparts in "Sources/Differentiation", except for the following:
  - Differentiable.swift
  - DifferentiationUtilities.swift
4. Enter this package's directory in the command line and run `build_gyb.sh`.

<!-- TODO: How to update tests -->
