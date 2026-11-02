# ``SwifterSwiftSpriteKit``

Extensions for SpriteKit nodes, such as `SKNode` and `SKSpriteNode`.

## Overview

These extensions are available on all Apple platforms. On platforms without SpriteKit, the module is empty.

Every extension lives in its own source file and doesn't depend on any other SwifterSwift code. Use the whole module, or copy a single file into your project.

```swift
import SwifterSwiftSpriteKit

let scene = SKScene(size: CGSize(width: 100, height: 100))
let box = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
scene.addChild(box)
box.topLeft = CGPoint(x: 0, y: 100)
box.frame  // (0.0, 50.0, 50.0, 50.0)
```
