//
//  SwiftUIView.swift
//  
//
//  Created by Beatriz Leonel da Silva on 14/04/23.
//

import SwiftUI

struct GameOverView: View {
    var body: some View {
        ZStack {
            Color.black
            Text("Game Over!!")
                .font(.title)
                .foregroundColor(.white)
        }
        .ignoresSafeArea()
    }
}

