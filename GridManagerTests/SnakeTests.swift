//
//  SnakeTests.swift
//  extremeSnake
//
//  Created by Felix Schilling on 15.06.17.
//  Copyright © 2017 DennisSchilling. All rights reserved.
//

import XCTest
import SpriteKit

class SnakeTests: XCTestCase {
    //let gridManager = GridManager(cells: 144, inScene: GameScene(size: CGSize(width: 160, height: 90)))
    let snake = Snake(atPoint: CGPoint.init(x: 0, y: 0), managedBy: GridManager(cells: 144, inScene: GameScene(size: CGSize(width: 160, height: 90))))
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    
    func testSnakedetermineTexture(){
        //XCTAssertEqual(snake.determineTexture(originDirection: .up, destinationDirection: .up), SKTexture(image:#imageLiteral(resourceName: "straight")))
        
    }

}
