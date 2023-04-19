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
    @State var showGameView = false
    @State var showStoryView = false
    @State var showHowToGameView = false
    @State var showHomeView = true
    
    @State var appeared: Double = 0
    
    var body: some View {
        let gameView = GameView(gameDelegate: self)
        let winView = WinView()
        let gameOverView = GameOverView()
        ZStack {
            if showHomeView {
                homeView
                storyView
                howToGameView
            }
            else if showGameView {
                gameView
                    .transition(.opacity)
            }
            else if showWinView {
                winView
                    .transition(.opacity)
            }
            else if showGameOverView {
                gameOverView
                    .transition(.opacity)
            }
        }
        .background(
            Image("Background")
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
                Text("Go Sleep!")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
                    .padding([.top, .bottom], 25)
                    .padding([.leading, .trailing], 45)
                
            }
            .background(Color.black)
            .cornerRadius(10)
            .shadow(color: .black ,radius: 8)
            
            Button(action: {
                activateHowToPlayView()
            }){
                Text("How to play")
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundColor(.white)
                    .padding([.top, .bottom], 15)
                    .padding([.leading, .trailing], 30)
                
            }
            .background(Color.black)
            .cornerRadius(10)
            .shadow(color: .black ,radius: 8)
            
        }
        .transition(.scale)
    }
    
    var storyView: some View {
        ModalView(isShowing: $showStoryView, titleString: "") {
            VStack(alignment: .center) {
                Text("Aqui é a área para adicionar o texto")
                Spacer()
                startButton
            }
        }
    }
    
    var howToGameView: some View {
        ModalView(isShowing: $showHowToGameView, titleString: "How to Play") {
            VStack(alignment: .center) {
                Text("Aqui é a área para adicionar o texto")
            }
        }
    }
    
    var startButton: some View {
        Button(action: {
            activateGameView()
        }){
            Text("Start")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.white)
                .padding([.top, .bottom], 25)
                .padding([.leading, .trailing], 45)
            
        }
        .background(Color.black)
        .cornerRadius(10)
        .shadow(color: .black ,radius: 8)
    }
    
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
    
    private func activateHowToPlayView() {
        withAnimation {
            showHowToGameView.toggle()
        }
    }
    
}

extension PresentingView: GameProtocol {
    func win() {
        withAnimation {
            showGameView = false
            showWinView = true
            AudioManager.shared.playSound(sound: .victory)
        }
    }
    
    func gameOver(timeDuration: String) {
        withAnimation {
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
