# ``SwifterSwiftHealthKit``

Extensions for HealthKit, such as the activity rings of `HKActivitySummary`.

## Overview

These extensions are available on iOS, iPadOS, macOS, watchOS, visionOS and Mac Catalyst. On tvOS and other platforms without HealthKit, the module is empty.

Importing this module links HealthKit into your app. App Review may reject an app that links HealthKit without using it, so add the module only to apps that work with health data.

Every extension lives in its own source file and doesn't depend on any other SwifterSwift code. Use the whole module, or copy a single file into your project.

```swift
import SwifterSwiftHealthKit

let rings = [summary.isMoveGoalMet, summary.isExerciseTimeGoalMet, summary.isStandGoalMet]
rings.allSatisfy { $0 }  // true when all three rings are closed
```
