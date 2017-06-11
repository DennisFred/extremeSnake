//
//  Snake.swift
//  extremeSnake
//
//  Created by Dennis Schilling on 10.06.17.
//  Copyright © 2017 DennisSchilling. All rights reserved.
//

import Foundation

enum direction{
    case up, right, down, left
}

struct Snake{
    var snakeDirection = direction.right
    private var snakeElements : [SnakeElement]
    
    var reachedBaseLength = false
    
    init (atPoint: CGPoint, withSize: CGSize){
        snakeElements = [];
        snakeElements.append(SnakeElement(atPoint: atPoint, withSize: withSize, after: nil))
    }
    
    func move(){
        
    }
    
    func getDirection() -> direction{
        return snakeDirection;
    }
    
    mutating func tryToChangeDirection(newDirection : direction){
        if((snakeDirection == .up || snakeDirection == .down) && (newDirection == .right || newDirection == .left)){
            snakeDirection = newDirection
        }
        if((snakeDirection == .right || snakeDirection == .left) && (newDirection == .up || newDirection == .down)){
            snakeDirection = newDirection
        }
    }
}
