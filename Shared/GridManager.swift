//
//  GridManager.swift
//  extremeSnake
//
//  Created by Dennis Schilling on 11.06.17.
//  Copyright © 2017 DennisSchilling. All rights reserved.
//

import Foundation

struct GridManager{
    let columns: Int!
    var rows: Int!
    var cellSize: CGSize!
    
    init(columns: Int, sceneSize: CGSize) {
        self.columns = columns
        
        let cellWidth = sceneSize.width > sceneSize.height ? sceneSize.height / CGFloat(self.columns) : sceneSize.width / CGFloat(self.columns)
        self.cellSize = CGSize(width: cellWidth, height: cellWidth)
        self.rows = Int(sceneSize.height / cellSize.height)

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
    
    func getNeighbouringCell(of: CGPoint, inDirection: direction) -> CGPoint{
        let currentPosition = getGridPositionFromCell(point: of)
        let newPosition: (x:Int, y:Int)
        switch inDirection {
        case .up:
            newPosition.y = (((currentPosition.y + 1) + (rows / 2)) % rows) - (rows/2)
            newPosition.x = currentPosition.x
            break
        default:
            newPosition.y = 0
            newPosition.x = 0
            break
        }
        return getCellPositionFromGrid(x: newPosition.x, y: newPosition.y)
    }
    
    
    
}
