# ``SwifterSwiftStdlib``

Extensions for the Swift standard library.

## Overview

These extensions use only the Swift standard library, so they work everywhere Swift runs: Apple platforms, Linux, Android, WebAssembly and Windows.

Every extension lives in its own source file and doesn't depend on any other SwifterSwift code. Use the whole module, or copy a single file into your project.

```swift
import SwifterSwiftStdlib

let numbers = [10, 20, 30]
numbers[safe: 3]  // nil
```
