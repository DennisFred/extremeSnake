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
    var gridManager: GridManager!
    private var objectSpawners: [ObjectSpawner]?
    
    class func newGameScene(withSize: CGSize) -> GameScene {
        // Load 'GameScene.sks' as an SKScene.
        print(withSize)
        
        let scene = GameScene(size: withSize)
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .fill
        
        return scene
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpScene() {
        // Get label node from scene and store it for use later
        if label == nil{
            label = createLabel()
            self.addChild(label!)
        }
        
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        gridManager = GridManager(cells: 255, inScene: self)
        
        objectSpawners = []
        objectSpawners?.append(FoodSpawner(inScene: self, managedBy: gridManager))
        
        initializeSnake()
        drawLabel()
    }
    
    func createLabel() -> SKLabelNode{
        let newLabel = SKLabelNode(text: "0")
        return newLabel
    }
    
    func initializeSnake(){
        snake = Snake(atPoint: gridManager.getCellPositionFromGrid(x: 0, y: 0), managedBy: gridManager)
        self.addChild(snake)
    }
    
    func killSnake(){
        snake.removeFromParent()
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
        if lastFrame == nil{
            lastFrame = currentTime
        }
        
        let speed = snake.getSpeed()
        
        if lastFrame! + speed < currentTime{
            snake.move()
            lastFrame = currentTime
            
            drawLabel()
            
            trySpawningObjects()
            
            if snake.getStatus() == .bidItself{
                gameOver()
            }
        }
    }
    func drawLabel(){
        if let label = self.label {
            if let labelValue = Int(label.text!){
                if labelValue != snake.getPoints(){
                    label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
                    label.text = String(snake.getPoints())
                }
            }
        }
    }
    func trySpawningObjects(){
        if let spawners = objectSpawners{
            for spawner in spawners {
                spawner.tryToSpawnObjects()
            }
        }
    }
    
    func gameOver(){
        killSnake()
        initializeSnake()
        
        if let spawners = objectSpawners{
            for spawner in spawners {
                spawner.removeAllObjects()
            }
        }
    }
    
    func pointBasedSteeringInput(atPoint: CGPoint){
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
        case .onScreenControls:
            
            break
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
    
    func keyBasedSteeringInput(keyCode: Int){
        let leftArrowKey = 123
        let rightArrowKey = 124
        let downArrowKey = 125
        let upArrowKey = 126
        
        switch keyCode {
        case leftArrowKey:
            snake.tryToChangeDirection(newDirection: .left)
            break
        case rightArrowKey:
            snake.tryToChangeDirection(newDirection: .right)
            break
        case upArrowKey:
            snake.tryToChangeDirection(newDirection: .up)
            break
        case downArrowKey:
            snake.tryToChangeDirection(newDirection: .down)
            break
        default:
            break
        }

    }
}

#if os(iOS) || os(tvOS)
    // Touch-based event handling
    extension GameScene {
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            for t in touches { self.pointBasedSteeringInput(atPoint: t.location(in: self)) }
        }
    }
#endif

#if os(OSX)
    // Mouse-based event handling
    extension GameScene {
        
        override func mouseDown(with event: NSEvent) {
            let mousePosition = event.location(in: self)
            pointBasedSteeringInput(atPoint: mousePosition)
        }
        
        override func keyDown(with event: NSEvent) {
            keyBasedSteeringInput(keyCode: Int(event.keyCode))
        }
        
    }
#endif

