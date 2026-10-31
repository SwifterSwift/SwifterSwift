# ``SwifterSwift``

Every SwifterSwift area in a single import.

## Overview

`SwifterSwift` re-exports all area modules, so one import gives you every extension that's available on the platform you're building for:

```swift
import SwifterSwift
```

Each area is also available as its own product if you only need part of the library:

| Module | Extends |
|---|---|
| `SwifterSwiftStdlib` | The Swift standard library |
| `SwifterSwiftFoundation` | Foundation |
| `SwifterSwiftCoreGraphics` | Core Graphics and Core Animation |
| `SwifterSwiftUIKit` | UIKit |
| `SwifterSwiftAppKit` | AppKit |
| `SwifterSwiftCoreLocation` | Core Location |
| `SwifterSwiftMapKit` | MapKit |
| `SwifterSwiftSpriteKit` | SpriteKit |
| `SwifterSwiftCryptoKit` | CryptoKit |
| `SwifterSwiftHealthKit` | HealthKit |

Every extension lives in its own source file and doesn't depend on any other SwifterSwift code, so you can also copy a single file into your project.

> Note: Importing `SwifterSwift` links HealthKit, because it includes `SwifterSwiftHealthKit`. If your app doesn't use HealthKit, import the individual modules you need instead, because App Review can flag apps that link HealthKit without using it.
