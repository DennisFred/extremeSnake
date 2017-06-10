//
//  SnakeElement.swift
//  extremeSnake
//
//  Created by Dennis Schilling on 10.06.17.
//  Copyright © 2017 DennisSchilling. All rights reserved.
//

import Foundation
import SpriteKit

class SnakeElement{
    private let position: CGPoint
    private var elementTexture: SKTexture
    private let elementSpriteNode: SKSpriteNode
    private var previousSnakeElement : SnakeElement?
    private var nextSnakeElement : SnakeElement?
    
    init(atPoint: CGPoint, withSize: CGSize, after:SnakeElement?) {
        position = atPoint
        elementTexture = SKTexture(image: #imageLiteral(resourceName: "SnakeElementSprite"))
        elementSpriteNode = SKSpriteNode(texture: elementTexture, size: withSize)
        previousSnakeElement = after
        
    }
}
