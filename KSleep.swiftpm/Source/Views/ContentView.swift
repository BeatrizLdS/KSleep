import SwiftUI
import SpriteKit

struct ContentView: View {
    
    var gameScene: SKScene {
        let scene = GameScene()
        return scene
    }
    
    var body: some View {
        SpriteView(scene: gameScene)
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
    }
}
