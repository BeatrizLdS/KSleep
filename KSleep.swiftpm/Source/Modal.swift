//
//  File.swift
//  
//
//  Created by Beatriz Leonel da Silva on 19/04/23.
//

import SwiftUI

struct ModalView<Content: View>: View {
    
    @Binding var isShowing: Bool
    var contentView: () -> Content
    var action: () -> Void
    
    var body: some View {
        ZStack(alignment: .center) {
            if isShowing {
                VStack(alignment: .center, spacing: 30) {
                    VStack(alignment: .center, spacing: 30) {
                        ZStack(content: contentView)
                    }
                    .padding([.top, .bottom], 50)
                    .padding(.horizontal, 30)
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.8)
                    .background(Color.white.opacity(0.95))
                    .cornerRadius(15)
                    .overlay(alignment: .topTrailing) {
                        close
                    }
                    startButton
                }
                .transition(.scale(scale: 0))
                
            }
            
        }
        .onTapGesture {
            isShowing = false
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .ignoresSafeArea()
    }
    
    var close: some View {
        Button {
            withAnimation{
                isShowing = false
            }
        } label: {
            Image(systemName: "xmark")
                .symbolVariant(.circle.fill)
                .font(
                    .system(size: 35, weight: .bold, design: .rounded)
                )
                .foregroundStyle(.gray.opacity(0.9))
                .padding(8)
        }

    }
    
    var startButton: some View {
        Button(action: {
            action()
        }){
            Text("Let's go!")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.black)
                .padding([.top, .bottom], 25)
                .padding([.leading, .trailing], 45)
            
        }
        .background(Color(UIColor.button!))
        .cornerRadius(10)
        .shadow(color: .black ,radius: 8)
    }
}

