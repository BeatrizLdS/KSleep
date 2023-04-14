import SwiftUI
import SpriteKit

struct GameView: View {

    @State var hour: Int = 10
    @State var timePeriod = "PM"
    var gameDelegate: GameProtocol?
    
    var gameScene: SKScene {
        let scene = GameScene()
        scene.timerDelegate = self
        return scene
    }
    
    var spriteView: SpriteView {
        let view = SpriteView(scene: gameScene)
        return view
    }

    var timerText: Text {
        var text = Text("\(hour) \(timePeriod)")
        text = text.font(.system(size: 40, weight: .bold))
        text = text.fontWeight(.bold)
        text = text.foregroundColor(.white)
        return text
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                spriteView
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                HStack{
                    Spacer()
                    timerText
                        .padding([.trailing, .top], 50)
                }
            }
        }
    }
}

extension GameView: TimerDelegate {
    func addOneHour() {
        hour = hour + 1
        if hour == 13 {
            hour = 1
            timePeriod = "AM"
        }
        if hour == 6 {
            gameDelegate?.win()
        }
    }
}
