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
    
    
    var length = 5 {
        didSet(newLength){
            speed *= 0.9;
        }
    }
    var speed : Double = 0.8;
    
    init (atPoint: CGPoint){
        snakeElements = [];
        snakeElements.append(SnakeElement(atPoint: atPoint))
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
