# ``SwifterSwiftCoreLocation``

Extensions for Core Location, such as geodesic math on `CLLocation`.

## Overview

These extensions are available on all Apple platforms. Extensions for Core Location types that only some platforms have, such as `CLVisit`, are available only there. On platforms without Core Location, the module is empty.

Every extension lives in its own source file and doesn't depend on any other SwifterSwift code. Use the whole module, or copy a single file into your project.

```swift
import SwifterSwiftCoreLocation

let paris = CLLocation(latitude: 48.8566, longitude: 2.3522)
let berlin = CLLocation(latitude: 52.5200, longitude: 13.4050)
paris.bearing(to: berlin)  // 58.18
```
