//
//  ContentView.swift
//  FigmaChallenge
//
//  Created by Débora Lage on 13/08/24.
//

import SwiftUI

public enum Experience {
    case bad
    case notBad
    case good
}

struct ContentView: View {
    
    @State var userExperience: Experience = .notBad
    @State private var currentValue = 1
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
    var experienceText: String {
        switch userExperience {
        case .bad:
            return "Bad"
        case .notBad:
            return "Not bad"
        case .good:
            return "Good"
        }
    }
    @State var mouthDegree: Double = 270
    @State var eyeFrame: (width: CGFloat?, height: CGFloat) = (103, 38)
    @State var eyeSpacing: Double = 20
    @State var areEyesSpinning: Bool = false
    
    var body: some View {
        VStack {
            buttonsView
            
            Text("How was your shopping experience?")
            
            Spacer()
            
            faceView
            
            Spacer()
            
            experienceTextView
            
            Spacer()
            
            sliderView

            CustomSliderView(range: 0...3, value: $currentValue)
            
//            Slider(value: $currentValue, in: 0...2)
        }
        .padding()
        .background(primaryColor)
    }
    
    var buttonsView: some View {
        HStack {
            Button {
                print("xmark button tapped")
            } label: {
                Image(systemName: "xmark")
                    .renderingMode(.template)
                    .foregroundStyle(secondaryColor)
            }
            .frame(width: 54, height: 54)
            .background(Color.black.opacity(0.05))
            .clipShape(Circle())
            
            Spacer()
            
            Button {
                print("xmark button tapped")
            } label: {
                Image(systemName: "info.circle")
                    .renderingMode(.template)
                    .foregroundStyle(secondaryColor)
            }
            .frame(width: 54, height: 54)
            .background(Color.black.opacity(0.05))
            .clipShape(Circle())
        }
    }
    
    var faceView: some View {
        VStack(spacing: 0) {
            eyesView
            mouthView
        }
    }
    
    var eyesView: some View {
        HStack(spacing: eyeSpacing) {
            Capsule(style: .circular)
                .frame(width: eyeFrame.width, height: eyeFrame.height)
                .rotationEffect(.degrees(areEyesSpinning ? -90 : 0))
                .animation(.easeInOut(duration: 0.5), value: areEyesSpinning)
            
            Capsule(style: .circular)
                .frame(width: eyeFrame.width, height: eyeFrame.height)
                .rotationEffect(.degrees(areEyesSpinning ? 90 : 0))
                .animation(.easeInOut(duration: 0.5), value: areEyesSpinning)
        }
        .foregroundStyle(secondaryColor)
    }
    
    var mouthView: some View {
        SemiCircumferenceShape()
            .rotation(Angle(degrees: mouthDegree))
            .stroke(secondaryColor, style: StrokeStyle(lineWidth: 20, lineCap: .round))
            .frame(width: 75, height: 50)
    }
    
    var experienceTextView: some View {
        Text(experienceText.uppercased())
            .font(Font.system(size: 64, weight: .black))
            .kerning(-4)
            .foregroundStyle(textColor)
    }
    
    var sliderView: some View {
        HStack {
            Button {
                withAnimation(.bouncy) {
                    eyeFrame = (60, 60)
                    eyeSpacing = 40
                    mouthDegree = 270
                    areEyesSpinning.toggle()
                }
                userExperience = .bad
            } label: {
                Text("Bad")
                    .foregroundStyle(.black)
            }
            .frame(height: 50)
            .background(.ultraThinMaterial)
            
            Button {
                withAnimation(.bouncy) {
                    eyeFrame = (103, 38)
                    eyeSpacing = 20
                    mouthDegree = 270
                    if userExperience == .bad { areEyesSpinning.toggle() }
                }
                userExperience = .notBad
            } label: {
                Text("Not bad")
                    .foregroundStyle(.black)
            }
            .frame(height: 50)
            .background(.ultraThinMaterial)
            
            Button {
                withAnimation(.bouncy) {
                    eyeFrame = (128, 128)
                    eyeSpacing = 16
                    mouthDegree = 90
//                    areEyesSpinnig.toggle()
                }
                userExperience = .good
            } label: {
                Text("Good")
                    .foregroundStyle(.black)
            }
            .frame(height: 50)
            .background(.ultraThinMaterial)
        }
    }
}

#Preview {
    ContentView()
}

