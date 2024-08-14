//
//  CustomSliderView.swift
//  FigmaChallenge
//
//  Created by Débora Lage on 13/08/24.
//

import SwiftUI

struct CustomSliderView: View {
    var range: ClosedRange<Int> = 0...3
    @Binding var value: Int
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(height: 6)
                .padding(30)
            
            Circle()
                .foregroundStyle(.ultraThinMaterial)
                .frame(height: 32)
            
            HStack {
                ForEach(range, id: \.self) { index in
                    Circle()
                        .frame(height: 16)
                    if index != range.last {  Spacer() }
                }
            }.padding(20)
        }
    }
}


#Preview {
    CustomSliderView(value: .constant(6))
}
