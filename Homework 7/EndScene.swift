//
//  EndScene.swift
//  Homework 7
//
//  Created by Aaron Sargento on 3/7/17.
//  Copyright © 2017 Aaron Sargento. All rights reserved.
//

// Input: The user can tap on screen to start playing the game again
// Output: The user will be taken to the Game Scene

import SpriteKit
import GameplayKit

class EndScene: SKScene {
    
    /*
        This function takes in a Boolean value to determine whether to post "You Win!" or "Game Over"
    */
    init(size: CGSize, playerWon: Bool) {
        super.init(size: size)
        backgroundColor = UIColor.black
        
        let rect = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        let midX = rect.midX
        let midY = rect.midY
        
        //set the game title for the scene
        let titleLabel = SKLabelNode(fontNamed: "Marker Felt")
        titleLabel.fontSize = 100
        titleLabel.position = CGPoint(x: midX, y: midY + 500)
        titleLabel.text = "Breakout Game"
        addChild(titleLabel)
        
        //add an image to the scene
        let logo = SKSpriteNode(imageNamed: "Logo")
        logo.size = CGSize(width: 600, height: 300)
        logo.position = CGPoint(x: midX, y: midY + 300)
        addChild(logo)
        
        //Label for result
        let resultLabel = SKLabelNode(fontNamed: "Marker Felt")
        resultLabel.fontSize = 60
        resultLabel.position = CGPoint(x: midX, y: midY + 80)
        addChild(resultLabel)
        
        //Label to prompt user to play again
        let promptLabel = SKLabelNode(fontNamed: "Marker Felt")
        promptLabel.fontSize = 60
        promptLabel.position = CGPoint(x: midX, y: midY - 100)
        addChild(promptLabel)
        
        if playerWon {
            resultLabel.text = "You Won!"
        } else {
            resultLabel.text = "Game Over"
        }
        promptLabel.text = "Tap to Play Again!"
        
        //add a ball to the scene
        let ball = SKSpriteNode(imageNamed: "Ball")
        ball.size = CGSize(width: 50.0, height: 50.0)
        ball.position = CGPoint(x: midX, y: midY)
        addChild(ball)
        
        //add a paddle to the scene
        let paddle = SKSpriteNode()
        paddle.size = CGSize(width: 200, height: 30)
        paddle.position = CGPoint(x: midX, y: midY - 550)
        paddle.color = UIColor.gray
        addChild(paddle)
        
    }
    
    /*
        Required when subclassing SKScene, for NSCoding protocol: archiving objects stored on the disk
    */
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    /*
        This function allows the user to go the Game Scene
    */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let gameScene = GameScene(fileNamed: "GameScene.sks")
        gameScene!.scaleMode = .aspectFill
        
        //use a transition to the gameScene
        let reveal = SKTransition.fade(withDuration: 1)
        
        //transition from current scene to the new scene
        scene?.view?.presentScene(gameScene!, transition: reveal)
    }
    
}

