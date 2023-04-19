//
//  Room.swift
//  KSleep
//
//  Created by Beatriz Leonel da Silva on 11/04/23.
//

import SpriteKit

enum RoomState: String {
    case `default` = "RoomDefault"
    case animated = "Room"
}

class Room: SKSpriteNode {
    private var frames: [SKTexture] = []
    private var state: RoomState = .default
    var animated = false
    
    init() {
        super.init(texture: SKTexture(imageNamed: state.rawValue), color: .clear, size: .zero)
        name = "Room"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeShadows() {
        animated = true
        loopForever(state: .animated)
    }

    func stopShadows() {
        removeAllActions()
        animated = false
        state = .default
        texture = SKTexture(imageNamed: state.rawValue)
    }
    
    private func loopForever(state: RoomState) {
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
