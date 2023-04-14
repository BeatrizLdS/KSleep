//
//  WinView.swift
//  
//
//  Created by Beatriz Leonel da Silva on 13/04/23.
//

import SwiftUI

struct WinView: View {
    var body: some View {
        ZStack {
            Color.black
            Text("Win!!")
                .font(.title)
                .foregroundColor(.white)
        }
        .ignoresSafeArea()
    }
}
