//
//  StartScene.swift
//  Homework 7
//
//  Created by Aaron Sargento on 3/7/17.
//  Copyright © 2017 Aaron Sargento. All rights reserved.
//

// Input: The user can tap on the screen to play the game
// Output: The user will be taken to the Game Scene

import SpriteKit
import GameplayKit

class StartScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        backgroundColor = UIColor.black
        
        let rect = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        let midX = rect.midX
        let midY = rect.midY
        
        //set the game title
        let titleLabel = SKLabelNode(fontNamed: "Marker Felt")
        titleLabel.fontSize = 50
        titleLabel.position = CGPoint(x: midX, y: midY + 250)
        titleLabel.text = "Breakout Game"
        addChild(titleLabel)
        
        //add an image
        let logo = SKSpriteNode(imageNamed: "Logo")
        logo.size = CGSize(width: 400, height: 200)
        logo.position = CGPoint(x: midX, y: midY + 150)
        addChild(logo)
        
        //add prompt label to the scene
        let tapStartLabel = SKLabelNode(fontNamed: "Marker Felt")
        tapStartLabel.fontSize = 30
        tapStartLabel.fontColor = SKColor.white
        tapStartLabel.position = CGPoint(x: midX, y: midY - 50)
        tapStartLabel.text = "Tap to start the game"
        addChild(tapStartLabel)
        
        //add a ball
        let ball = SKSpriteNode(imageNamed: "Ball")
        ball.size = CGSize(width: 25.0, height: 25.0)
        ball.position = CGPoint(x: midX, y: midY)
        addChild(ball)
        
        //add a paddle
        let paddle = SKSpriteNode()
        paddle.size = CGSize(width: 100, height: 15)
        paddle.position = CGPoint(x: midX, y: midY - 275)
        paddle.color = UIColor.gray
        addChild(paddle)
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
