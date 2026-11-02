# ``SwifterSwiftFoundation``

Extensions for Foundation.

## Overview

These extensions work wherever Foundation is available: Apple platforms, Linux, Android, WebAssembly and Windows.

Every extension lives in its own source file and doesn't depend on any other SwifterSwift code. Use the whole module, or copy a single file into your project.

The module includes a privacy manifest that declares its use of `UserDefaults`. If you copy a `UserDefaults` extension into your project instead, declare the API in your app's own privacy manifest.

```swift
import SwifterSwiftFoundation

let url = URL(string: "https://example.com/search?q=swift")!
url.queryValue(for: "q")  // "swift"
```
