//
//  GameScene.swift
//  Spaceee
//
//  Created by iD Student on 7/5/17.
//  Copyright © 2017 iDTech. All rights reserved.
//

import SpriteKit
import GameplayKit

struct BodyType {
    
    static let None: UInt32 = 0
    static let Meteor: UInt32 = 1
    static let Bullet: UInt32 = 2
    static let Hero: UInt32 = 4
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    let hero = SKSpriteNode(imageNamed:"Spaceship")
    
    let heroSpeed: CGFloat = 150.0
    
    var meteorScore = 0
    
    var scoreLabel = SKLabelNode(fontNamed: "Arial")
    
    override func didMove(to view: SKView) {
        
        backgroundColor = SKColor.black
        
        
        // score label
        scoreLabel.fontColor = UIColor.white
        
        scoreLabel.fontSize = 40
        
        scoreLabel.position = CGPoint(x: 0, y: 270)
        
        addChild(scoreLabel)
        
        scoreLabel.text = "0"
        
        
        
        let xCoord = 0
        let yCoord = 0
        
        hero.size.height = 50
        hero.size.width = 50
        
        hero.position = CGPoint(x: xCoord, y: yCoord)
        
        hero.physicsBody = SKPhysicsBody(rectangleOf: hero.size)
        hero.physicsBody?.isDynamic = true
        hero.physicsBody?.categoryBitMask = BodyType.Hero
        hero.physicsBody?.contactTestBitMask = BodyType.Meteor
        hero.physicsBody?.collisionBitMask = 0
        
        addChild(hero)
        
        
        let swipeUp: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedUp))
        
        swipeUp.direction = .up
        
        view.addGestureRecognizer(swipeUp)
       

        let swipeDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedDown))
        
        swipeDown.direction = .down
        
        view.addGestureRecognizer(swipeDown)
        
        
        let swipeLeft: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedLeft))
        
        swipeLeft.direction = .left
        
        view.addGestureRecognizer(swipeLeft)
        
        
        let swipeRight: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedRight))
        
        swipeRight.direction = .right
        
        view.addGestureRecognizer(swipeRight)
        
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addMeteor), SKAction.wait(forDuration: 0.35)])))
        
        physicsWorld.gravity = CGVector(dx:0, dy:0)
        
        physicsWorld.contactDelegate = self
        
    }
    
    
    func swipedUp(sender:UISwipeGestureRecognizer){
        var actionMove: SKAction
        
        actionMove = SKAction.move(to: CGPoint (x: hero.position.x, y: hero.position.y + heroSpeed), duration: 0.4)
        
        hero.run(actionMove)
        print("Up")
        
    }
    
    func swipedDown(sender:UISwipeGestureRecognizer){
        var actionMove: SKAction
        
        actionMove = SKAction.move(to: CGPoint (x: hero.position.x, y: hero.position.y - heroSpeed), duration: 0.4)
        
        hero.run(actionMove)
        
        print("Down")
    }
    
    func swipedLeft(sender:UISwipeGestureRecognizer){
        var actionMove: SKAction
        
        actionMove = SKAction.move(to: CGPoint (x: hero.position.x - heroSpeed, y: hero.position.y), duration: 0.4)
        
        hero.run(actionMove)
        
        print("Left")
    }
    
    func swipedRight(sender:UISwipeGestureRecognizer){
        var actionMove: SKAction
        
        actionMove = SKAction.move(to: CGPoint (x: hero.position.x + heroSpeed, y: hero.position.y), duration: 0.4)
        
        hero.run(actionMove)
        
        print("Right")
    }
    
//    func random() -> CGFloat {
//        
//        return CGFloat(Float(arc4random()) / Float(UINT32_MAX))
//        
//    }
    
    func addMeteor () {
        
        var meteor: Enemy
        meteor = Enemy(imageNamed: "MeteorLeft")
        
        meteor.size.height = 35
        meteor.size.width = 50
        
        let random = GKRandomDistribution(lowestValue: -370, highestValue: 370)
        
        let randomY = random.nextInt()
        
//        let randomY = random() * ((size.height - meteor.size.height/2)-meteor.size.height/2) + meteor.size.height/2
        
        meteor.position = CGPoint(x: 590, y: randomY)
        
        meteor.physicsBody = SKPhysicsBody(rectangleOf: meteor.size)
        meteor.physicsBody?.isDynamic = true
        meteor.physicsBody?.categoryBitMask = BodyType.Meteor
        meteor.physicsBody?.contactTestBitMask = BodyType.Bullet
        meteor.physicsBody?.collisionBitMask = 0

        addChild(meteor)
        
        var moveMeteor: SKAction
        
        moveMeteor = SKAction.move(to: CGPoint (x: -580, y: randomY), duration: (5.0))
        
        
        meteor.run(SKAction.sequence([moveMeteor, SKAction.removeFromParent()]))
    }
    
    
//======================================================================
//    func touchDown(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.green
//            self.addChild(n)
//        }
//    }
//    
//    func touchMoved(toPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.blue
//            self.addChild(n)
//        }
//    }
//    
//    func touchUp(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.red
//            self.addChild(n)
//        }
//    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        
//        
//    }
//    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        
//    }
//    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let bullet = SKSpriteNode()
        
        bullet.color = UIColor.green
        bullet.size = CGSize(width: 5, height: 5)
        
        bullet.position = CGPoint(x: hero.position.x, y: hero.position.y)
        
        bullet.physicsBody = SKPhysicsBody(circleOfRadius: bullet.size.width/2)
        bullet.physicsBody?.isDynamic = true
        bullet.physicsBody?.categoryBitMask = BodyType.Bullet
        bullet.physicsBody?.contactTestBitMask = BodyType.Meteor
        bullet.physicsBody?.collisionBitMask = 0
        bullet.physicsBody?.usesPreciseCollisionDetection = true
        
        addChild(bullet)
        
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self)
        
        let vector = CGVector(dx: -(hero.position.x - touchLocation.x), dy: -(hero.position.y - touchLocation.y))
        
        let projectileAction = SKAction.sequence([
            SKAction.repeat(
                SKAction.move(by: vector, duration: 0.5), count: 10),
            SKAction.wait(forDuration: 0.5),
            SKAction.removeFromParent()
            ])
        bullet.run(projectileAction)
    }
    
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//    }
//    
//    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
    }
    
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        let contactA = bodyA.categoryBitMask
        let contactB = bodyB.categoryBitMask
        
        switch contactA {
            
            case BodyType.Meteor:
            
            switch contactB {
                
                case BodyType.Meteor: break
                
                case BodyType.Bullet:
                
                    if let bodyBNode = contact.bodyB.node as? SKSpriteNode, let bodyANode = contact.bodyA.node as? Enemy {
                    
                        bulletHitMeteor(bullet: bodyBNode, meteor: bodyANode)
                    }
                
                case BodyType.Hero:
                
                    if let bodyBNode = contact.bodyB.node as? SKSpriteNode, let bodyANode = contact.bodyA.node as? Enemy {
                    
                        heroHitMeteor(player: bodyBNode, meteor: bodyANode)
                    }
                
                default: break
                
            }
            
            case BodyType.Bullet:
            
            switch contactB {
                
                case BodyType.Meteor:
                
                    if let bodyANode = contact.bodyA.node as? SKSpriteNode, let bodyBNode = contact.bodyB.node as? Enemy {
                    
                        bulletHitMeteor(bullet: bodyANode, meteor: bodyBNode)
                    
                    }
                
                case BodyType.Bullet: break
               
                case BodyType.Hero: break
                
                default: break
                
            }
            
            case BodyType.Hero:
            
            switch contactB {
                
                case BodyType.Meteor:
                
                    if let bodyANode = contact.bodyA.node as? SKSpriteNode, let bodyBNode = contact.bodyB.node as? Enemy {
                    
                        heroHitMeteor(player: bodyANode, meteor: bodyBNode)
                    
                    }
                
                case BodyType.Bullet: break
                
                case BodyType.Hero: break
                
                default: break
                
            }
            
            default:break
            
        }
        
    }
    
    func bulletHitMeteor (bullet:SKSpriteNode, meteor: Enemy) {
        bullet.removeFromParent()
        
        meteor.removeFromParent()
        
        meteorScore += 1
        
        scoreLabel.text = "\(meteorScore)"
        
        explodeMeteor(meteor: meteor)
        
    }
    
    func heroHitMeteor(player:SKSpriteNode, meteor: Enemy){
        removeAllChildren()
        // Label Code
        let gameOverLabel = SKLabelNode(fontNamed: "Arial")
        
        gameOverLabel.text = "Game Over"
        
        gameOverLabel.fontColor = UIColor.white
        
        gameOverLabel.fontSize = 40
        
        gameOverLabel.position = CGPoint(x: 0, y: 0)
        
        addChild(gameOverLabel)
    }
    
    func explodeMeteor (meteor: Enemy){
        let explosions: [SKSpriteNode] = [SKSpriteNode(), SKSpriteNode(), SKSpriteNode(), SKSpriteNode(), SKSpriteNode()]
        
        for explosion in explosions {
            let random1 = GKRandomDistribution(lowestValue: 0, highestValue: 1000)
            let randomx = random1.nextInt()
            
            let random2 = GKRandomDistribution(lowestValue: 0, highestValue: 1000)
            let randomy = random2.nextInt()
            
            let randomExplosionX = (randomx)
            let randomExplosionY = (randomy)
            
            explosion.color = UIColor.orange
            explosion.size = CGSize(width:3, height: 3)
            explosion.position = CGPoint(x: meteor.position.x , y: meteor.position.y)
            
            let moveExplosion: SKAction
            
            moveExplosion = SKAction.move(to: CGPoint(x:randomExplosionX, y:randomExplosionY), duration: 10.0)
            
            explosion.run(SKAction.sequence([moveExplosion, SKAction.removeFromParent()]))
            
            addChild(explosion)
        }
        
        
    }

}
