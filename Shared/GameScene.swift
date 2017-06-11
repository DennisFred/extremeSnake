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

enum SteeringMode{
    case absoulteTouchPosition, relativeTouchPosition, onScreenControls
}

class GameScene: SKScene {
    fileprivate var label : SKLabelNode?
    private var snake : Snake!
    private var lastFrame : TimeInterval?
    
    private var steeringMode = SteeringMode.relativeTouchPosition
    
    private var gridManager: GridManager!
    
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
    
    func setUpScene() {
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//lengthLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        
        gridManager = GridManager(columns: 11, sceneSize: self.size)
        
        
        snake = Snake(atPoint: gridManager.getCellPositionFromGrid(x: 0, y: 0), managedBy: gridManager)
        
        self.addChild(snake)
    }
    
    func spawnFood(){
        let cellPosition = gridManager.getRandomCellPosition()
        let nodes = self.nodes(at: cellPosition).filter{type(of: $0) != SKLabelNode.self}
        
        if(nodes.count > 0){
            spawnFood();
        } else{
            self.addChild(Food(atPoint: cellPosition, withSize: gridManager.cellSize))
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
        /*
         if let label = self.label {
         label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
         }

         */
        if lastFrame == nil{
            lastFrame = currentTime
        }
        
        if lastFrame! + 1 > currentTime{
            snake.move()
            lastFrame = currentTime
        }
    }
    
    func steeringInput(atPoint: CGPoint){
        switch steeringMode{
        case .absoulteTouchPosition:
            if atPoint.x > 0{
                snake.tryToChangeDirection(newDirection: .right)
            } else {
                snake.tryToChangeDirection(newDirection: .left)
            }
            if atPoint.y > 0{
                snake.tryToChangeDirection(newDirection: .up)
            } else {
                snake.tryToChangeDirection(newDirection: .down)
            }
            break
        case .onScreenControls: break
        case .relativeTouchPosition :
            if let snakePosition = snake.getPosition(){
                if atPoint.x > snakePosition.x{
                    snake.tryToChangeDirection(newDirection: .right)
                } else {
                    snake.tryToChangeDirection(newDirection: .left)
                }
                if atPoint.y > snakePosition.y{
                    snake.tryToChangeDirection(newDirection: .up)
                } else {
                    snake.tryToChangeDirection(newDirection: .down)
                }
            }
            break
        }
    }
}

#if os(iOS) || os(tvOS)
    // Touch-based event handling
    extension GameScene {
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            
        }
    }
#endif

#if os(OSX)
    // Mouse-based event handling
    extension GameScene {
        
        override func mouseDown(with event: NSEvent) {
            let mousePosition = event.location(in: self)
            steeringInput(atPoint: mousePosition)
        }
        
    }
#endif

