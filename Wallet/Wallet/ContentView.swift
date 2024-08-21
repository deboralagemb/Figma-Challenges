//
//  ContentView.swift
//  Wallet
//
//  Created by Débora Lage on 20/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            
            VStack {
                buttonsView
                myCardsView
                carouselCard()
            }
            .padding(40)
            
        }
    }
    
    var buttonsView: some View {
        HStack {
            circularButton(image: "circle.grid.3x3.fill") { }
            Spacer()
            circularButton(image: "bell") { }
        }
    }
    
    var myCardsView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("My")
                    .foregroundStyle(.white.opacity(0.55))
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Cards")
                    .foregroundStyle(.white)
                    .font(.title)
                    .fontWeight(.bold)
            }
            
            
            Spacer()
            circularButton(image: "plus") { }
        }
    }
    
    @ViewBuilder
    func circularButton(image: String, action: () -> Void) -> some View {
        Button {

        } label: {
            Image(systemName: image)
                .renderingMode(.template)
                .resizable()
                .foregroundStyle(.white)
                .frame(width: 22, height: 22)
        }
        .frame(width: 54, height: 54)
        .background(Color.black.opacity(0.05))
        .clipShape(Circle())
    }
    
    @ViewBuilder
    func carouselCard() -> some View {
        EmptyView()
    }
}

#Preview {
    ContentView()
}
