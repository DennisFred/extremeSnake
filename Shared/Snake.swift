//
//  Snake.swift
//  extremeSnake
//
//  Created by Dennis Schilling on 10.06.17.
//  Copyright © 2017 DennisSchilling. All rights reserved.
//

import Foundation
import SpriteKit

enum direction{
    case up, right, down, left
}

class Snake: SKNode{
    var snakeDirection = direction.right
    
    var reachedBaseLength = false
    
    init (atPoint: CGPoint, withSize: CGSize){
        super.init()
        self.addChild(SnakeElement(atPoint: atPoint, withSize: withSize, after: nil))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func move(){
        
    }
    
    func getDirection() -> direction{
        return snakeDirection;
    }
    
    func tryToChangeDirection(newDirection : direction){
        if((snakeDirection == .up || snakeDirection == .down) && (newDirection == .right || newDirection == .left)){
            snakeDirection = newDirection
        }
        if((snakeDirection == .right || snakeDirection == .left) && (newDirection == .up || newDirection == .down)){
            snakeDirection = newDirection
        }
    }
}
