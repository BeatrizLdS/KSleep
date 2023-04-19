//
//  File.swift
//  
//
//  Created by Beatriz Leonel da Silva on 19/04/23.
//

import SwiftUI

struct ModalView<Content: View>: View {
    
    @Binding var isShowing: Bool
    var titleString: String
    var contentView: () -> Content
    
    var body: some View {
        ZStack(alignment: .center) {
            if isShowing {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isShowing = false
                        }
                    }
                VStack(alignment: .center, spacing: 30) {
                    title
                        .padding(.vertical, 10)
                    Spacer()
                    ZStack(content: contentView)
                    Spacer()
                }
                .frame(height: UIScreen.main.bounds.height * 0.7)
                .frame(maxWidth: UIScreen.main.bounds.width * 0.8)
                .background(Color.white)
                .cornerRadius(15)
                .transition(.scale(scale: 0))
                .overlay(alignment: .topTrailing) {
                    close
                }
                
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .ignoresSafeArea()
    }
    
    var title: some View {
        Text(titleString)
            .font(.system(size: 30, weight: .bold, design: .rounded))
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
                .foregroundStyle(.gray.opacity(0.8))
                .padding(8)
        }

    }
}

