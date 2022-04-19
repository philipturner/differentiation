# Differentiation

A workaround for enabling differentiation in Swift until the Standard Library officially supports it. This only compiles with Swift release toolchains, and may not reflect the most recent commits to [apple/swift](https://github.com/apple/swift/tree/main/stdlib/public/Differentiation).

> Warning: Swift's implementation of differentiation is still experimental. Bug fixes implemented in development toolchains may take months to integrate into release toolchains.

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

This package was used in an iOS [sample project](https://github.com/philipturner/differentiation-ios-demo) to find velocity from physics equations.

## Compatibility with Development Toolchains

To create differentiation code that compiles with and without Swift release toolchains, optionally depend on this package if compiling with a release toolchain. In addition, use this import guard at the top of your source files:

```swift
#if canImport(Differentiation)
import Differentiation
#else
import _Differentiation
#endif
```

> Note: When officially enabled in release toolchains, the built-in `_Differentiation` module will be renamed to `Differentiation`. If the compiler wants you to use the new module name, this guard could protect your code against deprecation warnings.

## Running Package Tests

To determine whether a release toolchain has certain bug fixes integrated into recent development toolchain, this package includes most AutoDiff compiler crasher tests. These produce errors and warnings in Xcode, which are intentional. The tests are considered successful if they do not crash the compiler.

## How to Update

To synchronize this package with the code in the [apple/swift](https://github.com/apple/swift) repository, follow these steps:
1. Locate [swift/stdlib/public/Differentiation](https://github.com/apple/swift/tree/main/stdlib/public/Differentiation) in the Swift GitHub repository.
2. Copy files ending with `.gyb` into "Sources/gyb-sources".
3. Copy all other Swift files into their counterparts in "Sources/Differentiation", except for the following:
- Differentiable.swift
- DifferentiationUtilities.swift
4. Enter this package's directory in the command line and run `build_gyb.sh`.
