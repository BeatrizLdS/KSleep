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
}

struct PresentingView: View {
    
    @State var showWinView = false
    @State var showGameOverView = false
    @State var showGameView = true
    @State var showHomeView = false
    
    @State var appeared: Double = 0
    
    var body: some View {
        let gameView = GameView(gameDelegate: self)
        let winView = WinView()
        let gameOverView = GameOverView()
        ZStack {
            Color.black
            if showGameView {
                gameView
            }
            if showWinView {
                winView
                    .transition(.opacity)
            }
            if showGameOverView {
                gameOverView
                    .transition(.opacity)
            }
        }
        .ignoresSafeArea()
    }
}

extension PresentingView: GameProtocol {
    func win() {
        withAnimation{
            showGameView = false
            showWinView = true
            AudioManager.shared.playSound(sound: .victory)
        }
    }
    
    func gameOver(timeDuration: String) {
        withAnimation{
            showGameView = false
            showGameOverView = true
            AudioManager.shared.playSound(sound: .gameOver)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        PresentingView()
    }
}
