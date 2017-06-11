//
//  Food.swift
//  extremeSnake
//
//  Created by Dennis Schilling on 11.06.17.
//  Copyright © 2017 DennisSchilling. All rights reserved.
//

import Foundation
import SpriteKit

class Food: SKSpriteNode, Cell{
    internal let type : CellType
    
    init(atPoint: CGPoint, withSize: CGSize, value:Int) {
        self.type = .food(value)
        super.init(texture: SKTexture(image: #imageLiteral(resourceName: "FoodSprite")), color:.clear, size: withSize)
        position = atPoint
    }
    
    convenience init(atPoint: CGPoint, withSize: CGSize){
        self.init(atPoint: atPoint, withSize: withSize, value: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
