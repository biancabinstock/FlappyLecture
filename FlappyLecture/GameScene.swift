//
//  GameScene.swift
//  FlappyLecture
//
//  Created by Bianca Binstock on 2015-05-20.
//  Copyright (c) 2015 Bianca Binstock. All rights reserved.
//
// to do- add pipes- login etc


import SpriteKit

class GameScene: SKScene {
//    create a sprite node/ anything you want to reference via code
    var bird = SKSpriteNode()
    var bg = SKSpriteNode()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */

        //      adding file path because its not it images folder, best practice for games
        var birdTexture = SKTexture (imageNamed: "Img/flappy1.png")
        var birdTexture2 = SKTexture (imageNamed: "Img/flappy2.png")
   
//       create animation
        var animation = SKAction.animateWithTextures([birdTexture, birdTexture2], timePerFrame: 0.1)
        var makePlayerAnimate = SKAction.repeatActionForever(animation)

//      these methods put the image in the middle of the screen
        bird.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(bird)
        

//      assign texture to node
        bird = SKSpriteNode(texture: birdTexture)

//      these methods put the image in the middle of the screen
        bird.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        bird.runAction(makePlayerAnimate)
        
//      add physics
        bird.physicsBody = SKPhysicsBody(circleOfRadius: bird.size.height/2)
        bird.physicsBody?.dynamic = true
        bird.physicsBody?.allowsRotation = false

//      layering for 2 d- give the feeling of depth - you should assign each node a z position
        bird.zPosition = 10
        self.addChild(bird)
        
//      define ground object
        var ground = SKNode()
//      set ground positiom
        ground.position = CGPointMake(0, 0)
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width,5))
        ground.physicsBody?.dynamic = false
        self.addChild(ground)
        
//      Add background
        var backgroundImage = SKTexture(imageNamed: "Img/bg.png")
        bg = SKSpriteNode(texture: backgroundImage)
        bg.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
//      set background size to height of screen
        bg.size.height = self.frame.height
        self.addChild(bg)
//        add time
        var timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector:Selector("makePipes"), userInfo: nil, repeats: true)
        
    }
    

    
    func makePipes() {
    
    //       create a gap
    var gap = bird.size.height * 4
    
    //       movement amount
    var movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
    
    //      gap offset
    var pipeOffset = CGFloat (movementAmount) - self.frame.size.height / 4
    
    //      move pipes
    var movePipes = SKAction.moveByX(-self.frame.size.width * 2, y:0, duration: NSTimeInterval(self.frame.size.width / 100))
    //     remove a pipe
    var removePipes = SKAction.removeFromParent()
    //       move and remove pipes
    var moveAndRemovePipes = SKAction.sequence([movePipes,removePipes])

    //       add pipes
    var pipe1Texture = SKTexture(imageNamed:"Img/pipe1.png")
    var pipe1 = SKSpriteNode(texture: pipe1Texture)
    //      add action
    pipe1.runAction(moveAndRemovePipes)
    pipe1.physicsBody = SKPhysicsBody(rectangleOfSize: pipe1.size)
    pipe1.physicsBody?.dynamic = false
        
    pipe1.position = CGPoint(x: CGRectGetMidX(self.frame) + self.frame.size.width, y:CGRectGetMidY(self.frame) + pipe1.size.height / 2 + gap / 2 + pipeOffset)
    self.addChild(pipe1)
    
    var pipe2Texture = SKTexture(imageNamed:"Img/pipe2.png")
    var pipe2 = SKSpriteNode(texture: pipe2Texture)
    //     add action
    pipe2.runAction(moveAndRemovePipes)
    pipe2.physicsBody = SKPhysicsBody(rectangleOfSize: pipe2.size)
    pipe2.physicsBody?.dynamic = false
    
        pipe2.position = CGPoint(x: CGRectGetMidX(self.frame) + self.frame.size.width, y: CGRectGetMidY(self.frame) - pipe1.size.height / 2 - gap / 2 + pipeOffset)
    self.addChild(pipe2)
    
    
    }
    
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        println("Flappy is flying")
        bird.physicsBody?.velocity = CGVectorMake(0,0)
        bird.physicsBody?.applyImpulse(CGVectorMake(0, 30))
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
            if location == bird.position {
                println("Flappy is touched")
            }
            
  
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}



























