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
            else if showStoryView {
                VStack(alignment: .center, spacing: 50) {
                    Text("Aqui é a área para ter o texto descrevendo a históra")
                        .font(.system(size: 25, weight: .medium))
                        .padding(20)
                        .frame(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.height/1.5)
                        .background(Color.white.opacity(0.8))
//                        .border(.black, width: 10)
                        .cornerRadius(10)
                    
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
                .transition(.scale)
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
            else if showHowToGameView {
                //MARK: Aqui vai mostrar a tela de tutoras
            }
        }
        .background(
            Image("Background")
                .resizable()
                .ignoresSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        )
    }
    
    private func activateStoryView() {
        withAnimation {
            showHomeView.toggle()
            showStoryView.toggle()
        }
    }
    
    private func activateGameView() {
        withAnimation {
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
