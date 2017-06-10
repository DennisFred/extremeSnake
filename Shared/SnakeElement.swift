//
//  SnakeElement.swift
//  extremeSnake
//
//  Created by Dennis Schilling on 10.06.17.
//  Copyright © 2017 DennisSchilling. All rights reserved.
//

import Foundation
import SpriteKit

class SnakeElement: SKSpriteNode, Cell{
    internal let type = CellType.snakeElement
    
    private var previousSnakeElement : SnakeElement?
    private var nextSnakeElement : SnakeElement?
    
    init(atPoint: CGPoint, withSize: CGSize, after:SnakeElement?) {
        super.init(texture: SKTexture(image: #imageLiteral(resourceName: "SnakeElementSprite")), color:.clear, size: withSize)
        position = atPoint
        previousSnakeElement = after
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
