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
    
    let direction : direction
    
    init(withSize: CGSize, pointing: direction, atPosition: CGPoint) {
        direction = pointing
        super.init(texture: SKTexture(image: #imageLiteral(resourceName: "head")), color:.clear, size: withSize)
        self.position = atPosition
    }
    
    func updateTexture(newTexture: SKTexture){
        self.texture = newTexture
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
