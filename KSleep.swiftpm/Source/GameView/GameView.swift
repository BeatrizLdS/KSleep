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

    var hourText: Text {
        var text = Text("\(hour)")
        text = text.font(.system(size: 40, weight: .medium))
        text = text.foregroundColor(.white)
        return text
    }
    
    var periodText: Text {
        var text = Text("\(timePeriod)")
        text = text.font(.system(size: 25, weight: .regular))
        text = text.foregroundColor(.white)
        return text
    }
    
    init(gameDelegate: GameProtocol) {
        self.gameDelegate = gameDelegate
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                spriteView
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                HStack{
                    Spacer()
                    HStack (alignment: .bottom, spacing: 5) {
                        hourText
                        periodText
                            .opacity(0.9)
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.trailing, geometry.size.width/8)
                    .padding(.bottom, geometry.size.height/6)
                    
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
