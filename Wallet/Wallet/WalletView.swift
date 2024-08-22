//
//  WalletView.swift
//  Wallet
//
//  Created by Débora Lage on 20/08/24.
//

import SwiftUI

struct WalletView: View {
    @StateObject var viewModel = WalletViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 42) {
                buttonsView
                    .padding(.horizontal, 40)
                myCardsView
                    .padding(.horizontal, 40)
                carouselCard()
                lastTransactionsView
                    .padding(.horizontal, 40)
            }
//            .padding(.horizontal, 40)
        }
        .background(Color.primaryBackground)
    }
    
    var buttonsView: some View {
        HStack {
            circularWhiteButton(image: "circle.grid.3x3.fill") { }
            Spacer()
            circularWhiteButton(image: "bell") { }
        }
    }
    
    var myCardsView: some View {
        HStack {
            VStack(alignment: .leading, spacing: -10) {
                Text("My")
                    .foregroundStyle(.white.opacity(0.55))
                    .font(Font.system(size: 44, weight: .bold))
                
                Text("Cards")
                    .foregroundStyle(.white)
                    .font(Font.system(size: 44, weight: .bold))
            }
            Spacer()
            circularWhiteButton(image: "plus") { }
        }
    }

    @ViewBuilder
    func circularWhiteButton(image: String, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Image(systemName: image)
                .renderingMode(.template)
                .resizable()
                .foregroundStyle(.white)
                .frame(width: 22, height: 22)
        }
        .frame(width: 54, height: 54)
        .background(Color.white.opacity(0.24))
        .clipShape(Circle())
    }
    
    @ViewBuilder
    func circularButtonWithText(image: String, title: String, action: @escaping () -> Void) -> some View {
        VStack(spacing: 0) {
            Button {
                action()
            } label: {
                Image(image)
                    .renderingMode(.template)
                    .resizable()
                    .foregroundStyle(.black)
                    .frame(width: 24, height: 24)
            }
            .frame(width: 54, height: 54)
            .background(Color.black.opacity(0.06))
            .clipShape(Circle())
            
            Text(title)
        }
    }
    
    @ViewBuilder
    func carouselCard() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 20) {
                ForEach(viewModel.cards, id: \.self) { card in
                    singularCardView
                }
                .containerRelativeFrame(.horizontal)
            }
            .scrollTargetLayout()
        }
        .contentMargins(.horizontal, 40, for: .scrollContent)
        .scrollTargetBehavior(.viewAligned)
    }
    
    var singularCardView: some View {
        VStack(spacing: 20) {
            HStack {
                Image("logo")
                    .resizable()
                    .frame(width: 53, height: 53)
                
                Spacer()
                
                Text("$ 15,000.75")
                    .font(Font.system(size: 30, weight: .black))
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Image("chip")
                        .resizable()
                        .frame(width: 29, height: 21)
                    
                    Text("•••• •••• •••• 1234")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("VALID THRU")
                    Text("12/35")
                }
            }
            
            HStack {
                Text("MUSAB ALFAWAL")
                Spacer()
            }
            
            Rectangle()
                .fill(Color.black.opacity(0.13))
                .frame(height: 1)
            
            HStack {
                circularButtonWithText(image: "send", title: "Send") { }
                Spacer()
                circularButtonWithText(image: "received", title: "Receive") { }
                Spacer()
                circularButtonWithText(image: "addMaterial", title: "Add") { }
            }
        }
        .padding(22)
        .background(Color.secondaryBackground)
        .mask(RoundedRectangle(cornerRadius: 28))
    }
    
    var lastTransactionsView: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: -5) {
                    Text("Last")
                        .foregroundStyle(.white.opacity(0.55))
                        .font(Font.system(size: 27, weight: .bold))
                    
                    Text("Transactions")
                        .foregroundStyle(.white)
                        .font(Font.system(size: 27, weight: .bold))
                }
                Spacer()
                circularWhiteButton(image: "arrow.up") { }
                    .rotationEffect(.degrees(45))
            }
            
            transactionItem(transaction: viewModel.cards[0].transactions[0])
            transactionItem(transaction: viewModel.cards[0].transactions[1])
        }
    }
    
    @ViewBuilder
    func transactionItem(transaction: CardTransaction) -> some View {
        HStack {
            Button {
    
            } label: {
                Image(transaction.isIncoming ? "received" : "send")
                    .renderingMode(.template)
                    .resizable()
                    .foregroundStyle(.white)
                    .frame(width: 22, height: 22)
            }
            .frame(width: 54, height: 54)
            .background(Color.white.opacity(0.24))
            .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(transaction.description)
                Text("May 24, 2024")
            }
            .foregroundStyle(.white)
            
            Spacer()
            Text("\(transaction.isIncoming ? "+" : "-") $\(transaction.value)")
                .foregroundStyle(.white)
                .padding(.trailing, 5)
        }
        .padding(10)
        .background(Color.white.opacity(0.14))
        .mask(
            Capsule()
        )
        
    }
    
}

#Preview {
    WalletView()
}
