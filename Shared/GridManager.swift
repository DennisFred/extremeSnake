//
//  GridManager.swift
//  extremeSnake
//
//  Created by Dennis Schilling on 11.06.17.
//  Copyright © 2017 DennisSchilling. All rights reserved.
//

import Foundation
import SpriteKit

struct GridManager{
    let columns: Int!
    var rows: Int!
    var cellSize: CGSize!
    let scene: SKScene
    
    init(columns: Int, inScene: SKScene) {
        self.columns = columns
        self.scene = inScene
        
        let cellWidth = scene.size.width > scene.size.height ? scene.size.height / CGFloat(self.columns) : scene.size.width / CGFloat(self.columns)
        
        self.cellSize = CGSize(width: cellWidth, height: cellWidth)
        self.rows = Int(scene.size.height / cellSize.height)
    }
    
    func getCellPositionFromGrid(x: Int, y: Int) -> CGPoint{
        let cellWidth = cellSize.width
        let cellHeight = cellSize.height
        return CGPoint(x:  CGFloat(x) * cellWidth, y: CGFloat(y) * cellHeight)
    }
    
    func getGridPositionFromCell(point: CGPoint) -> (x: Int, y:Int){
        let cellWidth = cellSize.width
        let cellHeight = cellSize.height
        
        let x = Int(point.x / cellWidth)
        let y = Int(point.y / cellHeight)
        
        return (x, y)
    }
    
    func getRandomCellPosition() -> CGPoint{
        let randomColumn = Int(arc4random_uniform(UInt32(columns-1)));
        let randomRow = Int(arc4random_uniform(UInt32(rows-1)));
        
        return getCellPositionFromGrid(x: randomColumn, y: randomRow)
    }
    
    func getRandomEmptyCellPosition() -> CGPoint{
        let cellPosition = getRandomCellPosition()
        let cellNodes = scene.nodes(at: cellPosition).filter{$0 is Cell}
        
        if(cellNodes.count > 0){
            return getRandomEmptyCellPosition()
        } else {
            return cellPosition
        }
    }
    
    func getNeighbouringCell(of: CGPoint, inDirection: direction) -> CGPoint{
        let currentPosition = getGridPositionFromCell(point: of)
        let newPosition: (x:Int, y:Int)
        switch inDirection {
        case .up:
            newPosition.y = (((currentPosition.y + 1) + (rows / 2)) % rows) - (rows/2)
            newPosition.x = currentPosition.x
            break
        case .down:
            newPosition.y = (((currentPosition.y - 1) + (rows / 2) + rows) % rows) - (rows/2)
            newPosition.x = currentPosition.x
            break
        case .right:
            newPosition.y = currentPosition.y
            newPosition.x = (((currentPosition.x + 1) + (columns / 2)) % columns) - (columns/2)
            break
        case .left:
            newPosition.y = currentPosition.y
            newPosition.x = (((currentPosition.x - 1) + (columns / 2) + columns) % columns) - (columns/2)
            break
        }
        return getCellPositionFromGrid(x: newPosition.x, y: newPosition.y)
    }
    
    
    
}
