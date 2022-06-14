# Differentiation

A workaround for enabling differentiation in Swift until the Standard Library officially supports it. This only compiles with Swift release toolchains, and may not reflect the most recent commits to [apple/swift](https://github.com/apple/swift/tree/main/stdlib/public/Differentiation).

> Warning: Swift's implementation of differentiation is still experimental. Bug fixes implemented in development toolchains may take months to integrate into release toolchains.

## How to use

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


> An example of using this package in Swift code. For an in-depth guide, read the [Differentiable Programming Manifesto](https://github.com/apple/swift/blob/main/docs/DifferentiableProgramming.md).

For a demonstration, examine the iOS [sample project](https://github.com/philipturner/differentiation-ios-demo). It uses differentiation to find velocity from physics equations. This was the first time differentiation ever ran on iOS, which only supports release toolchains.

## Compatibility with Development Toolchains

To create differentiation code that compiles with and without Swift release toolchains, only depend on this package when compiling with a release toolchain. In addition, use this import guard at the top of your source files:

```swift
#if canImport(Differentiation)
import Differentiation
#else
import _Differentiation
#endif
```

When officially enabled in release toolchains, the built-in `_Differentiation` module will be renamed to `Differentiation`. If the compiler wants you to use the new module name, this guard could protect your code against deprecation warnings.

## Warning

If you are using a development toolchain, ensure you DO NOT depend on this package. It only works with release toolchains. Failure to adhere to this warning may cause undefined behavior.

Swift has no built-in way to detect presence of development toolchains - if it does, please contact me immediately! If your project regularly compiles with both release and development toolchains, you may need a complex build system to ensure this conditional dependency. For example, the development toolchains you test might always be of a higher Swift version than the release toolchains. You may hard-code conditional checks for a specific Swift version, but this will break after the next Swift release.

```swift
#if swift(<=5.6.1)
// Include this Swift package dependency in your Package.swift
#else
// Do not include this Swift package dependency
#endif
```

## Running Package Tests

To determine whether a release toolchain has certain bug fixes integrated into the main branch of Swift, this package includes most AutoDiff compiler crasher tests. These produce warnings and errors in Xcode when opened as a standalone Swift package. The tests are considered successful if they do not crash the compiler.

## How to Update

To synchronize this package with the code in the [apple/swift](https://github.com/apple/swift) repository, follow these steps:
1. Locate [stdlib/public/Differentiation](https://github.com/apple/swift/tree/main/stdlib/public/Differentiation) in the Swift GitHub repository.
2. Copy files ending with `.gyb` into "Sources/gyb-sources".
3. Copy all other Swift files into their counterparts in "Sources/Differentiation", except for the following:
- Differentiable.swift
- DifferentiationUtilities.swift
4. Enter this package's directory in the command line and run `build_gyb.sh`.
5. Create a new Swift project depending on your branch and validate that it compiles. Extra points for using the iOS [sample project](https://github.com/philipturner/differentiation-ios-demo) as that validation test.
