# ``SwifterSwiftAppKit``

Extensions for AppKit.

## Overview

These extensions are available on macOS. Mac Catalyst apps use `SwifterSwiftUIKit` instead. On other platforms, the module is empty.

Every extension lives in its own source file and doesn't depend on any other SwifterSwift code. Use the whole module, or copy a single file into your project.

```swift
import SwifterSwiftAppKit

let card = NSView()
card.addSubviews([titleField, subtitleField, imageView])
```
