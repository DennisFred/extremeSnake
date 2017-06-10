//
//  SnakeElement.swift
//  extremeSnake
//
//  Created by Dennis Schilling on 10.06.17.
//  Copyright © 2017 DennisSchilling. All rights reserved.
//

import Foundation
import SpriteKit

class SnakeElement: Cell{
    internal let position: CGPoint
    internal let type = CellType.snakeElement
    internal let spriteNode: SKSpriteNode
    
    private var elementTexture: SKTexture
    private var previousSnakeElement : SnakeElement?
    private var nextSnakeElement : SnakeElement?
    
    init(atPoint: CGPoint, withSize: CGSize, after:SnakeElement?) {
        position = atPoint
        elementTexture = SKTexture(image: #imageLiteral(resourceName: "SnakeElementSprite"))
        spriteNode = SKSpriteNode(texture: elementTexture, size: withSize)
        previousSnakeElement = after
    }
}
