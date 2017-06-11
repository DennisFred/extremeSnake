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
    var snakeDirection = direction.up
    var steeringDirection : direction?
    var reachedBaseLength = false
    let gridManager: GridManager
    
    
    init (atPoint: CGPoint, managedBy: GridManager){
        self.gridManager = managedBy
        super.init()
        self.addChild(SnakeElement(atPoint: atPoint, withSize: gridManager.cellSize, after: nil))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func move(){
        if let newDirection = steeringDirection{
            snakeDirection = newDirection
            steeringDirection = nil
        }
        
        if let position = getPosition(){
            let newPosition = gridManager.getNeighbouringCell(of: position, inDirection: snakeDirection)
            self.addChild(SnakeElement(atPoint: newPosition, withSize: gridManager.cellSize, after: nil))
        }
    }
    
    func getDirection() -> direction{
        return snakeDirection;
    }
    
    func getPosition() -> CGPoint?{
        if let pos =  self.children.last?.position{
            return pos
        } else {
            return nil
        }
    }
    
    func tryToChangeDirection(newDirection : direction){
        if((snakeDirection == .up || snakeDirection == .down) && (newDirection == .right || newDirection == .left)){
            steeringDirection = newDirection
        }
        if((snakeDirection == .right || snakeDirection == .left) && (newDirection == .up || newDirection == .down)){
            steeringDirection = newDirection
        }
    }
}
