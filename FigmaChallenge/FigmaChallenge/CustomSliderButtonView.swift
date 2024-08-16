//
//  CustomSliderView.swift
//  FigmaChallenge
//
//  Created by Débora Lage on 13/08/24.
//

import SwiftUI

struct CustomSliderButtonView: View {
    @EnvironmentObject var viewModel: ContentViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(height: 7)
                .foregroundStyle(viewModel.tertiaryColor)
                .padding(.leading, 30)
                .padding(.trailing, 32)
            
            VStack(spacing: 30) {
                HStack {
                    ForEach(viewModel.range, id: \.self) { index in
                        Button {
                            withAnimation(.bouncy) {
                                if index == 0 { viewModel.badButtonPressed() }
                                if index == 1 { viewModel.notBadButtonPressed() }
                                if index == 2 { viewModel.goodButtonPressed() }
                            }
                        } label: {
                            VStack(alignment: .center, spacing: 20) {
                                Circle()
                                    .frame(height: 17)
                                    .foregroundStyle(viewModel.tertiaryColor)
                            }
                        }
                        
                        if index != viewModel.range.last { Spacer() }
                    }
                }
                .padding(.horizontal, 20)
            }
            
            HStack {
                if viewModel.userExperience == .good {
                    Spacer(minLength: 0)
                }
                
                circleButton
                
                if viewModel.userExperience == .bad {
                    Spacer()
                }
            }
            .padding(10)
            .animation(.easeInOut(duration: 0.5), value: viewModel.userExperience)
            
            
            HStack {
                ForEach(viewModel.range, id: \.self) { index in
                    Text(viewModel.experienceText[index])
                        .font(Font.custom("Inter 18pt", size: 16))
                        .fontWeight(.regular)
                        .foregroundStyle(viewModel.sliderTextColor(index == viewModel.targetIndex))
                    if index != viewModel.range.last { Spacer() }
                }
            }
            .padding(.top, 70)
            .padding(.leading, 14)
            .padding(.trailing, 10)
        }
        .padding(.horizontal, 15)
    }
    
    var circleButton: some View {
        ZStack {
            Circle()
                .foregroundStyle(viewModel.secondaryColor)
                .frame(height: 40)
            
            SemiCircumferenceShape()
                .rotation(Angle(degrees: viewModel.mouthDegree))
                .stroke(viewModel.primaryColor, style: StrokeStyle(lineWidth: 1.8, lineCap: .round))
                .frame(width: 20, height: 11)
                .padding(.bottom, viewModel.userExperience == .good ? -5 : 5)
        }

    }
}

#Preview {
    CustomSliderButtonView()
}
