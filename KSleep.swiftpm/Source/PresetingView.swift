//
//  SwiftUIView.swift
//  
//
//  Created by Beatriz Leonel da Silva on 14/04/23.
//

import SwiftUI
import UIKit

extension UIColor {
    static var blueSky = UIColor(named: "BlueSky")
    static var blueWall = UIColor(named: "BlueWall")
    static var purpleWall = UIColor(named: "PurpleWall")
    static var pinkBed = UIColor(named: "PinkBed")
    static var pinkPink = UIColor(named: "RandomColor")
    static var button = UIColor(named: "Button")
}

struct PresentingView: View {
    
    @State private var orientation = UIDevice.current.orientation
    
    @State var showWinView = false
    @State var showGameOverView = false
    @State var showGameView = false
    @State var showStoryView = false
    @State var showHomeView = true
    
    @State var appeared: Double = 0
    
    @State var hour: String = "6:00"
    @State var timePeriod: String = "AM"
    
    var body: some View {
        let gameView = GameView(gameDelegate: self)
        ZStack {
            if showHomeView {
                homeView
                storyView
            }
            else if showGameView {
                gameView
                    .transition(.scale(scale: 0))
            }
            else if showWinView {
                GameEndView(TitleString: "Congratulations!",
                            hourString: hour,
                            periodString: timePeriod,
                            state: .win,
                            restartGame: {restartView()})
            }
            else if showGameOverView {
                GameEndView(TitleString: "Game Over!",
                            hourString: hour,
                            periodString: timePeriod,
                            state: .lose,
                            restartGame: {restartView()})
            }
        }
        .background(
            imageBackground
        )
        .detectOrientation($orientation)
    }
    
    var imageBackground: some View {
        var imageName = ""
        if orientation.isLandscape {
            imageName = "Background-h"
        } else {
            imageName = "Background-v"
        }
        return(
            Image(imageName)
                .resizable()
                .ignoresSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        )
    }
    
    var homeView: some View {
        VStack(alignment: .center, spacing: 50){
            Button(action: {
                activateStoryView()
            }){
                Text("Start")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                    .padding([.top, .bottom], 25)
                    .padding([.leading, .trailing], 45)
                
            }
            .background(Color(UIColor.button!))
            .cornerRadius(10)
            .shadow(color: .black ,radius: 8)
        }
        .transition(.scale)
    }
    
    var storyView: some View {
        let texts = ["Alice is feeling sick during the day due to her difficulty staying asleep at night.",
        "To help her improve her mood during the day and get a good night's sleep, she needs a little help from you.",
        "Your goal is to prevent Alice's sleep level from reaching 0% between the hours of 10 pm and 6 am, so that she doesn't wake up before completing her 8 hours of sleep."]
        return (
            ModalView(isShowing: $showStoryView) {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(texts, id: \.self) {
                        Text("\($0)")
                            .padding([.leading, .trailing], 30)
                            .font(.system(size: 26,
                                          weight: .regular,
                                          design: .rounded))
                            .foregroundColor(.black)
                    }
                    Text("To do this, you must **tap the light** to turn it off whenever it comes on, **tap the window** to stop the high winds, and **tap the computer** to turn it off when it starts playing music.")
                        .padding([.leading, .trailing], 30)
                        .font(.system(size: 26,
                                      weight: .regular,
                                      design: .rounded))
                        .foregroundColor(.black)
                    
                }
            } action: {
                activateGameView()
            }
        )
    }
    
    
}

private extension PresentingView {
    private func activateStoryView() {
        withAnimation {
            showStoryView.toggle()
        }
    }
    
    private func activateGameView() {
        withAnimation {
            showHomeView.toggle()
            showStoryView.toggle()
            showGameView.toggle()
        }
    }
    
    private func restartView() {
        hour = "6:00"
        timePeriod = "AM"
        withAnimation {
            showWinView = false
            showGameOverView = false
            showHomeView.toggle()
        }
    }
}

extension PresentingView: GameProtocol {
    func gameOver(hour: String, timeperiod: String) {
        self.hour = hour
        self.timePeriod = timeperiod
        withAnimation {
            showGameView = false
            showGameOverView = true
        }
        UserDefaults.standard.set(false, forKey: "computer")
        UserDefaults.standard.set(false, forKey: "lighting")
        UserDefaults.standard.set(false, forKey: "curtain")
    }
    
    func win() {
        withAnimation {
            showGameView = false
            showWinView = true
        }
        UserDefaults.standard.set(false, forKey: "computer")
        UserDefaults.standard.set(false, forKey: "lighting")
        UserDefaults.standard.set(false, forKey: "curtain")
    }
}
