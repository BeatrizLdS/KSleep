import SwiftUI
import SpriteKit

protocol GameProtocol {
    func win()
    func gameOver(timeDuration: String)
}

struct GameView: View {

    @State var hour: Int = 10
    @State var minutes: Float = 0
    @State var minutesString: String = "00"
    @State var timePeriod = "PM"
    @State var sleepRate: CGFloat = 100
    @State var adictionalDistance: CGFloat = 0
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
        var text = Text("\(hour):\(minutesString)")
        text = text.font(.system(size: 35
                                 , weight: .medium))
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
            ZStack(alignment: .top) {
                VStack(alignment: .center) {
                    Spacer()
                    spriteView
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: 9 * (geometry.size.height/10))
                        .ignoresSafeArea()
                }
                
                HStack {
                    progressBar()
                        .frame(width: 6 * (geometry.size.width/10))
                    HStack{
                        Spacer()
                        HStack (alignment: .bottom, spacing: 5) {
                            hourText
                            periodText
                                .opacity(0.9)
                                .multilineTextAlignment(.leading)
                        }
                    }
                }
                .ignoresSafeArea()
                .frame(height: geometry.size.height/10)
                .padding([.trailing, .leading], geometry.size.width/10)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color.black)
    }
    
    func progressBar() -> some View {
        return (
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    
                    RoundedRectangle(cornerRadius: 60)
                        .stroke(Color(UIColor.pinkBed!), lineWidth: 2)
                    
                    ZStack(alignment: .trailing) {
                        RoundedRectangle(cornerRadius: 60)
                            .fill(Color(UIColor.pinkBed!))
                        Text("\(String(format: "%.0f", sleepRate))%")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .frame(width: 55)
                            .padding([.top, .bottom], 5)
                            .padding([.leading, .trailing], 10)
                            .background(
                                RoundedRectangle(cornerRadius: 60)
                                    .fill(Color(UIColor.pinkPink!))
                            )
                            .shadow(color: .black, radius: 2)
                        
                    }
                    .frame(width: (CGFloat(sleepRate + adictionalDistance) * geometry.size.width)/100, height: 25)
                }
            }
                .fixedSize(horizontal: false, vertical: true)
        )
    }
}

extension GameView: TimerDelegate {
    func decreaseSleepRate() {
        if sleepRate > 0.03 {
            sleepRate = sleepRate - 0.03
            if sleepRate < 90 && sleepRate > 89 {
                adictionalDistance = adictionalDistance + 0.03
            }
        } else {
            AudioManager.shared.turnAllSoundsOff()
            gameDelegate?.gameOver(timeDuration: "\(hour) \(timePeriod)")
        }
    }
    
    func addOneMinute() {
        minutes = minutes + 1
        if minutes == 60 {
            minutes = 0
            hour = hour + 1
        }
        if minutes/10 < 1 {
            minutesString = "0\(String(format:"%.0f", minutes))"
        } else {
            minutesString = (String(format:"%.0f", minutes))
        }
        if hour == 13 {
            hour = 1
            timePeriod = "AM"
        }
        if hour == 6 {
            AudioManager.shared.turnAllSoundsOff()
            gameDelegate?.win()
        }
    }
}
