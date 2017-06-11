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
        return CGPoint(x:  CGFloat(x) * cellWidth, y: CGFloat(y) * cellWidth)
    }
    
    func getRandomCellPosition() -> CGPoint{
        let randomColumn = Int(arc4random_uniform(UInt32(columns-1)));
        let randomRow = Int(arc4random_uniform(UInt32(rows-1)));
        
        return getCellPositionFromGrid(x: randomColumn, y: randomRow)
    }
    
    
    
}
