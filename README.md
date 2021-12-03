# Differentiation

A workaround for enabling differentiation in Swift until the standard library officially supports it. This is not needed in Swift development builds, and it may not reflect the most recent commits to the standard library.

> Note: There are bugs in Swift's current implementation of differentiation. Proceed at your own risk.

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
