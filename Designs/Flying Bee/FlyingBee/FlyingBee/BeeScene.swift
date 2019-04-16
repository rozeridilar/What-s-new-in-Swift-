//
//  BeeScene.swift
//  FlyingBee
//
//  Created by Kızılay on 15.04.2019.
//  Copyright © 2019 Rozeri Dilar. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation


let BeeDestroy: String = "BeeDestroy"
let BeeColorNotification: String = "BeeColor"
let BeeGameOverNotification: String = "BeeGameOver"
let BeeScreenHeightNotification: String = "BeeScreenHeightNotification"

let beeColors: [UIColor] = [UIColor(rgb: 0xdf0c8a),UIColor(rgb: 0xf2b04d),UIColor(rgb: 0x49b5e3),UIColor(rgb: 0xa9ce50),UIColor(rgb: 0xefe95d)]


class BeeScene: SKScene {
    
    var beeFrames: [SKTexture]?
    var bee: SKSpriteNode?
    var backColor: UIColor = .purple
    var beeScreenHeight: Int = 0
    //you always have to call required initializer if you want to have a ** custom initializer **
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        self.backgroundColor = backColor
        
        var frames:[SKTexture] = []
        
        let beeAtlas = SKTextureAtlas(named: "Bee")
        
        for index in 1 ... 6 {
            let textureName = "bee_\(index)"
            let texture = beeAtlas.textureNamed(textureName)
            frames.append(texture)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.setBeeHeight(_:)), name: NSNotification.Name(rawValue: BeeScreenHeightNotification), object: nil)
        self.beeFrames = frames
        self.bee = SKSpriteNode(texture: frames[0])
    }
    @objc func setBeeHeight(_ notification: NSNotification) {
        if let dict = notification.userInfo as NSDictionary? {
            if let h = dict[beeHeight] as? Int{
                // print("Color is \(color)")
                self.beeScreenHeight = h
            }
        }
    }
    var isGoingToDown: Bool = false
    
    func flyBee(){
        let texture = self.beeFrames![0]
        self.bee = SKSpriteNode(texture: texture)
        
        bee!.size = CGSize(width: 140, height: 140)
        
        let randomBeeXPositionGenerator = GKRandomDistribution(lowestValue: 50, highestValue: Int(self.frame.size.width))
        let xPosition = CGFloat(randomBeeXPositionGenerator.nextInt())
        
        let rightToLeft = arc4random() % 2 == 0
        
        let yPosition = rightToLeft ? self.frame.size.height + bee!.size.height / 2 : -bee!.size.height / 2
        
        bee!.position = CGPoint(x: xPosition, y: yPosition)
        
        if rightToLeft{
            bee!.xScale = -1
        }
        isGoingToDown = rightToLeft
        self.addChild(bee!)
        
        bee!.run(SKAction.repeatForever(SKAction.animate(with: self.beeFrames!, timePerFrame: 0.05, resize: false, restore: true)))
        
        var distanceToCover = self.frame.size.height + bee!.size.height
        
        if rightToLeft {
            distanceToCover *= -1
        }
        
        let velocity: CGFloat = CGFloat(140)
        
        let time = TimeInterval(abs(distanceToCover / velocity))
        
        let moveAction = SKAction.moveBy(x: 0, y: distanceToCover, duration: time)
        //let colorizeAction = SKAction.colorize(with: UIColor.red, colorBlendFactor: 1, duration: 1)
        
        let removeAction = SKAction.run {
            self.bee!.removeAllActions()
            self.bee!.removeFromParent()
        }
        
        let allActions = SKAction.sequence([moveAction,removeAction])
        
        let randomColor = beeColors.randomElement()!
        bee?.color = randomColor
        backColor = randomColor
        let colorDataDict:[String: UIColor] = ["color" : randomColor]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: BeeColorNotification), object: nil, userInfo: colorDataDict)
        
        bee?.colorBlendFactor = 1
        bee!.run(allActions)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if bee?.position == touch?.location(in: self){
            print("some")
        }
        let x = Int((bee?.position.x)!)
        let maxX = (touch?.location(in: self).x)! + 50
        let minX = (touch?.location(in: self).x)! - 50
        
        let y = Int((bee?.position.y)!)
        let maxY = (touch?.location(in: self).y)! + 20
        let minY = (touch?.location(in: self).y)! - 20
        
        if x < Int(maxX) && x > Int(minX) {
            if y < Int(maxY) && y > Int(minY) {
                
                NotificationCenter.default.post(name: Notification.Name(BeeDestroy), object: nil)
                
                //change background color with beeColor
                self.backgroundColor = backColor.withAlphaComponent(0.5)
                let pos = bee?.position
                self.bee?.removeAllActions()
                bee?.removeFromParent()
                //+3.0 == waitTimeToChangeColorBack
                self.explodeGem(pos!)
            }
        }
        
    }
    
    
    func explodeGem(_ pos: CGPoint){
        let emitter = SKEmitterNode(fileNamed: "gem")
        emitter?.position = pos
        addChild(emitter!)
        self.backgroundColor = .purple
        playSound(text: "Hello, World")
        flyBee()
    }
    
    func playSound(text: String){
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        
        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        let height = bee?.size.height ?? 30
        if bee!.position.y < -height/2.0 {
            bee!.removeFromParent()
            gameOver()
        }
        if beeScreenHeight != 0 && !isGoingToDown{
            if Int(bee!.position.y) == beeScreenHeight + Int(height/2.0){
                bee!.removeFromParent()
                gameOver()
            }
        }
    }
    
    func gameOver(){
        print("game over")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: BeeGameOverNotification), object: nil)
    }
    
}
