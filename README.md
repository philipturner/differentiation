# Differentiation

A workaround for enabling differentiation in Swift until the standard library officially supports it. Note that this is not needed in Swift development builds, and it may not reflect the most recent commits to the standard library.

## How to Use

```swift
import Differentiation

struct Example: Differentiable {
    ...
}

@differentiable(reverse)
func foo(...) {
    
}
```
