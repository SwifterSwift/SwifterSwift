# ``SwifterSwiftCryptoKit``

Extensions for CryptoKit.

## Overview

These extensions are available on all Apple platforms. CryptoKit is an Apple framework, so on other platforms, the module is empty.

Every extension lives in its own source file and doesn't depend on any other SwifterSwift code. Use the whole module, or copy a single file into your project.

```swift
import SwifterSwiftCryptoKit

Insecure.MD5.hash(data: Data()).hexString  // "d41d8cd98f00b204e9800998ecf8427e"
```
