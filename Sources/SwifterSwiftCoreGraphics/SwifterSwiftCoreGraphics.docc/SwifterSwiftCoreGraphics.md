# ``SwifterSwiftCoreGraphics``

Extensions for Core Graphics and Core Animation geometry types, such as `CGRect`, `CGPoint` and `CGSize`.

## Overview

These extensions are available on all Apple platforms. On platforms without Core Graphics, the module is empty.

Every extension lives in its own source file and doesn't depend on any other SwifterSwift code. Use the whole module, or copy a single file into your project.

```swift
import SwifterSwiftCoreGraphics

let frame = CGRect(x: 10, y: 20, width: 100, height: 50)
frame.center  // (60.0, 45.0)
```
