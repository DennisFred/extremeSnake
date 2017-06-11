//
//  GameScene.swift
//  extremeSnake
//
//  Created by Dennis Schilling on 10.06.17.
//  Copyright © 2017 DennisSchilling. All rights reserved.
//

import SpriteKit
#if os(watchOS)
    import WatchKit
    // SKColor typealias does not seem to be exposed on watchOS SpriteKit
    typealias SKColor = UIColor
#endif

class GameScene: SKScene {
    fileprivate var label : SKLabelNode?
    private var snake : Snake?
    private let columns: Int = 11
    private var rows: Int!
    private var cellSize: CGSize!
    
    
    class func newGameScene() -> GameScene {
        // Load 'GameScene.sks' as an SKScene.
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
            print("Failed to load GameScene.sks")
            abort()
        }
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        return scene
    }
    
    func getCellPositionFromGrid(x: Int, y: Int) -> CGPoint{
        let cellWidth = cellSize!.width
        return CGPoint(x:  CGFloat(x) * cellWidth, y: CGFloat(y) * cellWidth)
        
    }
    
    func setUpScene() {
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//lengthLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let cellWidth = self.size.width > self.size.height ? self.size.height / CGFloat(columns) : self.size.width / CGFloat(columns)
        cellSize = CGSize(width: cellWidth, height: cellWidth)
        rows = Int(self.size.height / cellSize!.height)
        
        let middleColumn = columns/2
        snake = Snake(atPoint: getCellPositionFromGrid(x: middleColumn, y: middleColumn), withSize: cellSize!)
    }
    
    func spawnFood(){
        let randomColumn = Int(arc4random_uniform(UInt32(columns-1)));
        let randomRow = Int(arc4random_uniform(UInt32(rows-1)));
        
        let cellPosition = getCellPositionFromGrid(x: randomColumn, y: randomRow)
        
        let nodes = self.nodes(at: cellPosition).filter{type(of: $0) != SKLabelNode.self}
        
        if(nodes.count > 0){
            spawnFood();
        } else{
            self.addChild(Food(atPoint: cellPosition, withSize: cellSize!))
        }
    }
    
    #if os(watchOS)
    override func sceneDidLoad() {
        self.setUpScene()
    }
    #else
    override func didMove(to view: SKView) {
        self.setUpScene()
    }
    #endif
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

#if os(iOS) || os(tvOS)
// Touch-based event handling
extension GameScene {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
    }
}
#endif

#if os(OSX)
// Mouse-based event handling
extension GameScene {

    override func mouseDown(with event: NSEvent) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
    }
    
}
#endif

