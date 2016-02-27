//
//  GameScene.swift
//  BuildGame
//
//  Created by Jeff on 2/27/16.
//  Copyright (c) 2016 JeffCole Inc. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
  
  // state
  var touchedNodes = [UITouch:SKNode]()

  // bitmasks
  let draggableCategory:UInt32 = 1

  // MARK: Init
  
  override func didMoveToView(view: SKView) {
    /* Setup your scene here */
    
    self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
  }
  
  // MARK: Updates
  
  override func update(currentTime: CFTimeInterval) {
    /* Called before each frame is rendered */
  }

  // MARK: Touches
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    /* Called when a touch begins */
    
    for touch in touches {
      let position = touch.locationInNode(self)
      if let draggableNode = getNodeForPosition(position) {
        setTouchForNode(touch, node:draggableNode)
        draggableNode.physicsBody?.affectedByGravity = false
      }
    }
  }
  
  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    for touch in touches {
      if let node = getNodeForTouch(touch) {
        moveNode(node, touch:touch)
      }
    }
  }
  
  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
      resetTouchForNodes()
  }
  
  // MARK: logic for dragging
  
  func getNodeForPosition(position:CGPoint) -> SKNode? {
    let touchedNode = self.nodeAtPoint(position)

    if let category = touchedNode.physicsBody?.categoryBitMask {
      if category == draggableCategory {
        return touchedNode
      }
    }

    return nil
  }
  
  func setTouchForNode(touch:UITouch, node:SKNode) {
    touchedNodes[touch] = node
  }

  func getNodeForTouch(touch:UITouch) -> SKNode? {
    return touchedNodes[touch]
  }

  func resetTouchForNodes() {
    for node in touchedNodes.values {
      node.physicsBody?.affectedByGravity = true
    }
    touchedNodes = [UITouch:SKNode]()
  }
  
  func moveNode(node:SKNode, touch:UITouch) {
    // TODO: use offset from node center
    // TODO: rotate when multiple touches
    
    let position = touch.locationInNode(self)
    node.position = position
  }
  
}
