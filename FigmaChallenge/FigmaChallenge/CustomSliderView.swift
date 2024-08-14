//
//  CustomSliderView.swift
//  FigmaChallenge
//
//  Created by Débora Lage on 13/08/24.
//

import SwiftUI

struct CustomSliderView: View {
    private var range: ClosedRange<Int> = 0...2
    private var feedbackOptions: [Experience] = [.bad, .notBad, .good]
    @Binding var value: Int
    @Binding var userExperience: Experience
    @Binding var mouthDegree: Double
    
    public init(value: Binding<Int>, 
                userExperience: Binding<Experience>,
                mouthDegree: Binding<Double>) {
        self._value = value
        self._userExperience = userExperience
        self._mouthDegree = mouthDegree
    }
    
    var primaryColor: Color {
        switch userExperience {
        case .bad:
            return .badPrimary
        case .notBad:
            return .notBadPrimary
        case .good:
            return .goodPrimary
        }
    }
    var secondaryColor: Color {
        switch userExperience {
        case .bad:
            return .badSecondary
        case .notBad:
            return .notBadSecondary
        case .good:
            return .goodSecondary
        }
    }
    var tertiaryColor: Color {
        switch userExperience {
        case .bad:
            return .badTertiary
        case .notBad:
            return .notBadTertiary
        case .good:
            return .goodTertiary
        }
    }
    var textColor: Color {
        switch userExperience {
        case .bad:
            return .badText
        case .notBad:
            return .notBadText
        case .good:
            return .goodText
        }
    }
    var experienceText: [String] = ["Bad", "Not bad", "Good"]
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(height: 7)
                .foregroundStyle(tertiaryColor)
                .padding(.leading, 30)
                .padding(.trailing, 32)
                .padding(.bottom, 38)
            
            HStack {
                ForEach(range, id: \.self) { index in
                    VStack(alignment: .center, spacing: 20) {
                        Circle()
                            .frame(height: 17)
                            .foregroundStyle(tertiaryColor)
                        
                        Text(experienceText[index])
                            .font(Font.custom("Inter", size: 16))
                            .fontWeight(.regular)
                            .foregroundStyle(secondaryColor)
                    }
                    
                    if index != range.last {  Spacer() }
                }
            }
            .padding(.horizontal, 20)
            
            circleButton
                .padding(.bottom, 40)
        }
    }
    
    var circleButton: some View {
        ZStack {
            Circle()
                .foregroundStyle(secondaryColor)
                .frame(height: 40)
            
            SemiCircumferenceShape()
                .rotation(Angle(degrees: mouthDegree))
                .stroke(primaryColor, style: StrokeStyle(lineWidth: 1.8, lineCap: .round))
                .frame(width: 20, height: 11)
                .padding(.bottom, userExperience == .good ? -2 : 5)
        }

    }
}

//#Preview {
//    CustomSliderView(value: .constant(6), userExperience: .constant(Experience.good))
//}
/*
var body: some View {
    GeometryReader { gr in
        let thumbSize = gr.size.height * 0.8
        let radius = gr.size.height * 0.5
        let minValue = gr.size.width * 0.015
        let maxValue = (gr.size.width * 0.98) - thumbSize
        
        ZStack {
            RoundedRectangle(cornerRadius: radius)
                .foregroundColor(.gray)
            HStack {
                Circle()
                    .foregroundColor(Color.white)
                    .frame(width: thumbSize, height: thumbSize)
                    .offset(x: self.value)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { v in
                                if (abs(v.translation.width) < 0.1) {
                                    self.lastCoordinateValue = self.value
                                }
                                if v.translation.width > 0 {
                                    self.value = min(maxValue, self.lastCoordinateValue + v.translation.width)
                                } else {
                                    self.value = max(minValue, self.lastCoordinateValue + v.translation.width)
                                }
                                
                            }
                    )
                Spacer()
            }
        }
    }
    .frame(height: 30)
*/
