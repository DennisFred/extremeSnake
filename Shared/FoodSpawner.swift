//
//  FoodSpawner.swift
//  extremeSnake
//
//  Created by Dennis Schilling on 11.06.17.
//  Copyright © 2017 DennisSchilling. All rights reserved.
//

import Foundation
import SpriteKit

class FoodSpawner : ObjectSpawner{
    private let gridManager: GridManager
    private let scene: SKScene
    
    init(inScene: SKScene, managedBy: GridManager) {
        gridManager = managedBy
        scene = inScene
    }
    
    func tryToSpawnObjects(){
        if scene.children.filter({$0 is Food}).count == 0 {
            spawnFood()
        }
        print(scene.children.count)
    }
    
    func spawnFood(){
        let cellPosition = gridManager.getRandomEmptyCellPosition()
        scene.addChild(Food(atPoint: cellPosition, withSize: gridManager.cellSize))
        
    }
    
    func removeAllObjects(){
        for child in scene.children.filter({$0 is Food}){
            child.removeFromParent()
        }
    }
}
