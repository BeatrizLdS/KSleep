//
//  Curtain.swift
//  KSleep
//
//  Created by Beatriz Leonel da Silva on 12/04/23.
//

import SpriteKit

enum CurtainState: String {
    case `default` = "CurtainDefault"
    case animated = "Curtain"
}

class Curtain: SKSpriteNode {
    private var frames: [SKTexture] = []
    private var state: CurtainState = .default
    var animated = false
    
    init() {
        super.init(texture: SKTexture(imageNamed: state.rawValue), color: .clear, size: .zero)
        name = "Curtain"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func applyWind() {
        animated = true
        loopForever(state: .animated)
    }

    func stopWind() {
        removeAllActions()
        animated = false
        state = .default
        texture = SKTexture(imageNamed: state.rawValue)
    }
    
    private func loopForever(state: CurtainState) {
        self.state = state
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
            with: state.rawValue,
            atlasName: state.rawValue
        )
        if  newFrames.isEmpty == false {
            self.frames = newFrames
        }
    }
    
}
