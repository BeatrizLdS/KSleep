//
//  Lighting.swift
//  KSleep
//
//  Created by Beatriz Leonel da Silva on 12/04/23.
//

import SpriteKit

class Lighting: SKSpriteNode {
    private var frames: [SKTexture] = []
    var animated = false
    
    init() {
        super.init(texture: SKTexture(), color: .clear, size: .zero)
        name = "Lighting"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func turnOn() {
        animated = true
        loopForever()
    }

    func turnOff() {
        removeAllActions()
        animated = false
        removeFromParent()
    }
    
    private func loopForever() {
        setFrames()
        let action = SKAction.animate(
            with: frames,
            timePerFrame: 1 / TimeInterval(frames.count),
            resize: false,
            restore: true
        )
        run(SKAction.repeatForever(action))
    }
    
    private func setFrames() {
        let newFrames = getFrames(
            with: "Lighting",
            atlasName: "Lighting"
        )
        if  newFrames.isEmpty == false {
            self.frames = newFrames
        }
    }
}
