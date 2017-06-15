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
    
    mutating func invertDirection(){
        switch self{
        case .up: self = .down
        case .right: self = .left
        case .down: self = .up
        case .left : self = .right
        }
    }
}

enum SnakeStatus{
    case allGood, bidItself
}

class Snake: SKNode{
    private var snakeDirection = direction.right
    private var steeringDirection : direction?
    private let gridManager: GridManager
    private var currentTargetLength = 5
    private var status = SnakeStatus.allGood
    
    
    init (atPoint: CGPoint, managedBy: GridManager){
        self.gridManager = managedBy
        super.init()
        self.addChild(SnakeElement(withSize: gridManager.cellSize, pointing: snakeDirection, atPosition: atPoint))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func move(){
        if let newDirection = steeringDirection{
            snakeDirection = newDirection
            steeringDirection = nil
        }
        
        while getLength() >= currentTargetLength{
            self.children.first!.removeFromParent()
        }
        
        if let position = getPosition(){
            let newPosition = gridManager.getNeighbouringCell(of: position, inDirection: snakeDirection)
            
            let nodesAtNewPosition = self.parent?.nodes(at: newPosition)
            
            reactToPotentialObstacles(nodes: nodesAtNewPosition)
            
            let formerHead = self.children.last! as! SnakeElement
            
            self.addChild(SnakeElement(withSize: gridManager.cellSize, pointing: snakeDirection, atPosition: newPosition))
            
            let currentHead = self.children.last! as! SnakeElement

            rotate(node: currentHead, toDirection: snakeDirection)
            
            formerHead.updateTexture(newTexture: determineTexture(originDirection: formerHead.direction, destinationDirection: snakeDirection))
        }
        
        if let newTail = self.children.first as? SnakeElement{
            newTail.updateTexture(newTexture: SKTexture(image: #imageLiteral(resourceName: "tail")))
            if self.children.count > 1, let secondElement = self.children[1] as? SnakeElement{
                rotate(node: newTail, toDirection: secondElement.direction)
            }
            
        }
        
        
    }
    
    func rotate(node:SKNode, toDirection:direction){
        switch toDirection {
        case .right:
            node.zRotation = 0
            break
        case .left:
            node.zRotation = CGFloat.pi
            break
        case .up:
            node.zRotation = CGFloat.pi / 2
            break
        case .down:
            node.zRotation = CGFloat.pi * 1.5
            break
        }

    }
    
    func determineTexture(originDirection:direction, destinationDirection:direction) -> SKTexture{
        var texture: SKTexture
        
        if originDirection == destinationDirection{
            texture = SKTexture(image:#imageLiteral(resourceName: "straight"))
        } else {
            switch (originDirection, destinationDirection){
            case (.left, .up), (.up, .right), (.right, .down), (.down, .left):
                texture = SKTexture(image:#imageLiteral(resourceName: "rightBend"))
                break
            default:
                texture = SKTexture(image:#imageLiteral(resourceName: "leftBend"))
                break
            }
        }
        return  texture
    }
    
    func getStatus() -> SnakeStatus{
        return status
    }
    
    func reactToPotentialObstacles(nodes:[SKNode]?){
        if let nodesAtPosition = nodes{
            for node in nodesAtPosition {
                if let cell = node as? Cell{
                    switch cell.type{
                    case .food(let nutritionalValue):
                        currentTargetLength += nutritionalValue
                        node.removeFromParent()
                        break
                    case .snakeElement:
                        //Game Over!
                        status = .bidItself
                        break
                    }
                }
            }
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
    
    func getLength() -> Int{
        return self.children.count
    }
    func getPoints() -> Int{
        return currentTargetLength
    }
    
    func getSpeed() -> Double{
        if getLength() < 5 {
            return 1
        } else {
            return 1 * pow(0.95, Double(getLength()-4))
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
