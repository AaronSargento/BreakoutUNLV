//
//  GameScene.swift
//  Homework 7
//
//  Created by Aaron Sargento on 3/2/17.
//  Copyright © 2017 Aaron Sargento. All rights reserved.
//

// Input: The user moves the paddle to hit the ball and hit the blocks.
// Output: When a block is hit, it will be removed and the score is updated. User will lose if ball goes past paddle. User will win if all the blocks are gone (score is 2,800).

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var ball = SKSpriteNode()
    var paddle = SKSpriteNode()
    var scoreLabel = SKLabelNode()
    
    //running score of the game
    var score: Int = 0
    
    //sound for removal of brick
    let brickSound = SKAction.playSoundFileNamed("brick.wav", waitForCompletion: false)
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor.black
        
        scoreLabel = self.childNode(withName: "Score") as! SKLabelNode
        
        //keep the ball in the scene
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0
        borderBody.restitution = 1
        self.physicsBody = borderBody
        
        //set the bottom to detect losing situation
        let bottomRect = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: 1.0)
        let bottom = SKNode()
        bottom.physicsBody = SKPhysicsBody(edgeLoopFrom: bottomRect)
        addChild(bottom)
        
        //keep the ball bouncing
        physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        ball = self.childNode(withName: "Ball") as! SKSpriteNode
        ball.physicsBody?.applyImpulse(CGVector(dx: 12.0, dy: -12.0))
        
        //set the paddle
        paddle = self.childNode(withName: "Paddle") as! SKSpriteNode
        
        //allow block to be removed when hit by ball
        physicsWorld.contactDelegate = self
        
    }

    /*
        This function allows the removal of a block when it is hit by ball and updates the score
    */
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBodyName = contact.bodyA.node?.name
        let secondBodyName = contact.bodyB.node?.name
        
        if firstBodyName == "Ball" && secondBodyName == "Block" || firstBodyName == "Block" && secondBodyName == "Ball"{
            if firstBodyName == "Block" {
                contact.bodyA.node?.removeFromParent()
            } else if secondBodyName == "Block" {
                contact.bodyB.node?.removeFromParent()
            }
            run(brickSound)
            score = score + 100
            scoreLabel.text = "Score: \(score)"
        }
    }

    /*
        This function allows the user to move the paddle when location is tapped
    */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let fingerLocation = t.location(in: self)
            let position = CGPoint(x: fingerLocation.x, y: paddle.position.y)
            paddle.run(SKAction.move(to: position, duration: 0.2))
        }
    }
    
    /*
        This function allows the paddle to be dragged
    */
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let fingerLocation = t.location(in: self)
            let position = CGPoint(x: fingerLocation.x, y: paddle.position.y)
            paddle.run(SKAction.move(to: position, duration: 0.2))
        }
    }

    /*
        This function will transition to the End scene when user wins or loses
    */
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        //Losing instance
        if ball.position.y <= paddle.position.y - 70 {
            let gameOverScene = EndScene(size: self.frame.size, playerWon: false)
            let reveal = SKTransition.fade(withDuration: 1)
            self.view?.presentScene(gameOverScene, transition: reveal)
        }
        
        //Winning instance
        if score == 2800 {
            let gameOverScene = EndScene(size: self.frame.size, playerWon: true)
            let reveal = SKTransition.fade(withDuration: 1)
            self.view?.presentScene(gameOverScene, transition: reveal)
        }
    }
}
