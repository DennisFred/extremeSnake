//
//  GridManager.swift
//  extremeSnake
//
//  Created by Dennis Schilling on 11.06.17.
//  Copyright © 2017 DennisSchilling. All rights reserved.
//
import Foundation
import SpriteKit

extension CGSize{
    func fillWith(numberOfSquares: Int) -> (rows:Int, columns:Int, squareSize: CGSize)?{
        let area = self.width * self.height
        if numberOfSquares > 0{
            let squareArea = area / CGFloat(numberOfSquares)
            
            let squareSize = CGSize(width: Int(squareArea.squareRoot()), height: Int(squareArea.squareRoot()))
            let rows = Int(self.height / squareSize.height)
            let columns = Int(self.width / squareSize.width)
            
            return (rows: rows, columns: columns, squareSize: squareSize)
        } else {
            return nil
        }
    }
}

struct GridManager{
    var columns: Int!
    var rows: Int!
    var cellSize: CGSize!
    var scene: SKScene
    
    init(cells: Int, inScene: SKScene) {
        self.scene = inScene
        initializeGrid(ofCells: cells)
    }
    
    mutating func initializeGrid(ofCells: Int){
        if let calculatedGrid = scene.size.fillWith(numberOfSquares: ofCells){
            cellSize = calculatedGrid.squareSize
            rows = calculatedGrid.rows
            columns = calculatedGrid.columns
        } else {
            fatalError("No valid cell number was provided!")
        }
    }
    
    
    func getCellPositionFromGrid(x: Int, y: Int) -> CGPoint{
        let cellWidth = Int(cellSize.width)
        let cellHeight = Int(cellSize.height)
        
        let xPos = x * cellWidth
        let yPos = y * cellHeight
        
        return CGPoint(x:  xPos, y: yPos)
    }
    
    func getGridPositionFromCell(point: CGPoint) -> (x: Int, y:Int){
        let cellWidth = cellSize.width
        let cellHeight = cellSize.height
        
        let x = Int(point.x / cellWidth)
        let y = Int(point.y / cellHeight)
        
        return (x, y)
    }
    
    func getRandomCellPosition() -> CGPoint{
        let randomColumn = Int(arc4random_uniform(UInt32(columns-1))) - (columns/2);
        let randomRow = Int(arc4random_uniform(UInt32(rows-1))) - (rows/2);
        
        return getCellPositionFromGrid(x: randomColumn, y: randomRow)
    }
    
    func getRandomEmptyCellPosition() -> CGPoint{
        let cellPosition = getRandomCellPosition()
        
        if(cellIsOccupied(atPosition: cellPosition)){
            return getRandomEmptyCellPosition()
        } else {
            return cellPosition
        }
    }
    
    func cellIsOccupied(atPosition position:CGPoint) -> Bool{
        let cellNodes = scene.nodes(at: position).filter{$0 is Cell}
        
        if(cellNodes.count > 0){
            return true
        } else {
            return false
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
