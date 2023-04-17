//
//  SwiftUIView.swift
//  
//
//  Created by Beatriz Leonel da Silva on 14/04/23.
//

import SwiftUI

struct PresentingView: View {
    
    @State var showWinView = false
    @State var showGameOverView = false
    @State var showGameView = true
    @State var showTitleView = false
    
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
        }
    }
    
    func gameOver(timeDuration: String) {
        withAnimation{
            showGameView = false
            showGameOverView = true            
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        PresentingView()
    }
}
