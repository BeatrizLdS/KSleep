//
//  SwiftUIView.swift
//  
//
//  Created by Beatriz Leonel da Silva on 19/04/23.
//

import SwiftUI

enum GameEndState: String {
    case lose = "You managed to keep Alice sleeping until"
    case win = "You helped Alice get a good night's sleep until"
}

struct GameEndView: View {
    @State var TitleString: String
    @State var hourString: String
    @State var periodString: String
    var state: GameEndState
    var restartGame: () -> Void
    
    var body: some View {
        VStack(alignment: .center) {
            ZStack (alignment: .top) {
                contentView
                titleView
            }
            tryAgainButton
        }
        .onAppear{
            switch state {
            case .lose:
                AudioManager.shared.playSound(sound: .gameOver)
            case .win:
                AudioManager.shared.playSound(sound: .victory)
            }
        }
    }
    
    var titleView: some View {
        Text(TitleString)
            .font(.system(size: 40, weight: .bold, design: .rounded))
            .padding(.horizontal, 50)
            .padding(.vertical, 30)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: .black, radius: 5)
    }
    
    var contentView: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(state.rawValue)
                .font(.system(size: 22, weight: .medium, design: .default))
            HStack(alignment: .center, spacing: 1) {
                hourText
                periodText
            }
        }
        .padding(.top, 100)
        .padding(.bottom, 50)
        .frame(width: UIScreen.main.bounds.width * 0.7)
        .background(Color.white)
        .cornerRadius(10)
        .padding(50)
        .shadow(color: .black, radius: 5)
    }
    
    var hourText: Text {
        var text = Text(hourString)
        text = text.font(.system(size: 25, weight: .semibold))
        return text
    }
    
    var periodText: Text {
        var text = Text(periodString)
        text = text.font(.system(size: 20, weight: .medium))
        return text
    }
    
    var tryAgainButton: some View {
        Button{
            restartGame()
        } label: {
            Text("Try Again")
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .padding([.top, .bottom], 25)
                .padding([.leading, .trailing], 45)
        }
        .background(Color.black)
        .cornerRadius(10)
        .shadow(color: .black ,radius: 8)
    }
    
}