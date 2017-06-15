//
//  GridManagerTests.swift
//  GridManagerTests
//
//  Created by Dennis Schilling on 13.06.17.
//  Copyright © 2017 DennisSchilling. All rights reserved.
//

import XCTest
import SpriteKit

class MockCell: SKSpriteNode, Cell{
    var type: CellType
    
    init(atPoint: CGPoint, withSize: CGSize, value:Int = 1) {
        self.type = .food(value)
        super.init(texture: SKTexture(image: #imageLiteral(resourceName: "FoodSprite")), color:.clear, size: withSize)
        position = atPoint
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class GridManagertest: XCTestCase {
    let gridManager = GridManager(cells: 144, inScene: GameScene(size: CGSize(width: 160, height: 90)))
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCGSizeFillWithSquares(){
        let testCGSize = CGSize(width: 16, height: 9)
        let squares = 144
        
        let result = testCGSize.fillWith(numberOfSquares: squares)
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result!.rows, 9)
        XCTAssertEqual(result!.columns, 16)
        XCTAssertEqual(result!.squareSize, CGSize(width: 1,height: 1))
        
    }
    
    func testGridManagerinitialization(){
        XCTAssertEqual(gridManager.cellSize.width, 10)
        XCTAssertEqual(gridManager.columns, 16)
        XCTAssertEqual(gridManager.rows, 9)
        XCTAssert(gridManager.scene is GameScene)
    }
    func testGridManagerPositionConversions(){
        let cellPosition = gridManager.getCellPositionFromGrid(x: 5, y: 6)
        
        XCTAssertEqual(cellPosition.x, 50)
        XCTAssertEqual(cellPosition.y, 60)
        
        let backconvertedPoint = gridManager.getGridPositionFromCell(point: cellPosition)
        
        XCTAssertEqual(backconvertedPoint.x, 5)
        XCTAssertEqual(backconvertedPoint.y, 6)
    }
    
    func testGridManagerNeighbourFinding(){
        let origin = CGPoint(x: 0, y: 0)
        XCTAssertEqual(
            gridManager.getNeighbouringCell(of: origin, inDirection: .up),
            CGPoint(x:0, y:10))
        XCTAssertEqual(
            gridManager.getNeighbouringCell(of: origin, inDirection: .right),
            CGPoint(x:10, y:0))
        XCTAssertEqual(
            gridManager.getNeighbouringCell(of: origin, inDirection: .down),
            CGPoint(x:0, y:-10))
        XCTAssertEqual(
            gridManager.getNeighbouringCell(of: origin, inDirection: .left),
            CGPoint(x:-10, y:0))
    }
    
    func testGridManageCellChecking(){
        let testPoint = CGPoint(x: 0, y: 0)
        
        gridManager.scene.addChild(MockCell(atPoint: testPoint, withSize: gridManager.cellSize))
        
        XCTAssert(gridManager.cellIsOccupied(atPosition: testPoint))
    }
    
}

