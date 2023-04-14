//
//  GameScene.swift
//  KSleep
//
//  Created by Beatriz Leonel da Silva on 11/04/23.
//

import Foundation
import SpriteKit

class GameScene: SKScene {
    
    var lastUpdateTime: TimeInterval = 0
    var animationRate = 0.008
    var timerDelegate: TimerDelegate?
    
    let room: Room = {
        let room = Room()
        room.yScale = 0.7
        return room
    } ()
    
    let curtain: Curtain = {
        let curtain = Curtain()
        curtain.yScale = 0.7
        curtain.zPosition = 1
        return curtain
    } ()
    
    lazy var curtainHitArea: SKShapeNode = {
        let node = SKShapeNode(rectOf: CGSize(width: frame.width/7, height: frame.height/6))
        node.fillColor = .clear
        node.strokeColor = .clear
        return node
    } ()
    
    let lighting: Lighting = {
        let lighting = Lighting()
        lighting.yScale = 0.7
        return lighting
    } ()
    
    lazy var lightingHitArea: SKShapeNode = {
        let node = SKShapeNode(rectOf: CGSize(width: frame.width/7, height: frame.height/7))
        node.fillColor = .clear
        node.strokeColor = .clear
        return node
    } ()
    
    let computer: Computer = {
        let computer = Computer()
        computer.yScale = 0.7
        computer.isUserInteractionEnabled = true
        return computer
    } ()
    
    lazy var computerHitArea: SKShapeNode = {
        let node = SKShapeNode(rectOf: CGSize(width: frame.width/7, height: frame.height/7))
        node.fillColor = .clear
        node.strokeColor = .clear
        return node
    } ()
    
    override func didMove(to view: SKView) {
        backgroundColor = .clear
        setScene()
    }
    
    override func update(_ currentTime: TimeInterval) {
        let randomNumber = Double.random(in: 0...1)
        if randomNumber < animationRate {
            activateRandomAnimation()
        }
        
        let timeInSeconds = calculateDeltaTime(from: currentTime)
        if timeInSeconds >= 15 {
            animationRate = animationRate + 0.002
            lastUpdateTime = 0
            timerDelegate?.addOneHour()
        }
    }
    
    private func activateRandomAnimation() {
        let objects = [curtain, lighting, computer]
        
        if let randomObject = objects.randomElement() {
            if randomObject is Curtain {
                if curtain.animated == false {
                    curtain.applyWind()
                    room.changeShadows()
                }
            } else if randomObject is Computer {
                if computer.animated == false {
                    addChild(computer)
                    computer.turnOn()
                }
            } else {
                if lighting.animated == false {
                    addChild(lighting)
                    lighting.turnOn()
                }
            }
        }
    }

    private func calculateDeltaTime(from currentTime: TimeInterval) -> TimeInterval {
        if lastUpdateTime.isZero {
            lastUpdateTime = currentTime
        }
        
        let deltaTime = currentTime - lastUpdateTime
        return deltaTime
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let touchLocation = touch.location(in: self)
        
        if curtainHitArea.contains(touchLocation) {
            if curtain.animated {
                curtain.stopWind()
                room.stopShadows()
            }
        }
        
        if lightingHitArea.contains(touchLocation) {
            if lighting.animated {
                lighting.turnOff()
            }
        }
        
        if computerHitArea.contains(touchLocation) {
            if computer.animated {
                computer.turnOff()
            }
        }
    }
}


extension GameScene: SetSceneProtocol {
    func setPosition() {
        let objects = [room, curtain, lighting, computer]
        
        for node in objects {
            node.position = CGPoint(
                x: frame.midX,
                y: frame.midY
            )
            node.calculateSize(
                windowWidth: frame.width,
                windowHeight: frame.height
            )
        }
        
        curtainHitArea.position = CGPoint(
            x: frame.width * 0.43,
            y: frame.height * 0.64
        )

        lightingHitArea.position = CGPoint(
            x: frame.width * 0.63,
            y: frame.height * 0.5
        )

        computerHitArea.position = CGPoint(
            x: frame.width * 0.3,
            y: frame.height * 0.47
        )
    }
    
    func addChilds() {
        addChild(room)
        addChild(curtain)
        addChild(curtainHitArea)
        addChild(lightingHitArea)
        addChild(computerHitArea)
    }
}

