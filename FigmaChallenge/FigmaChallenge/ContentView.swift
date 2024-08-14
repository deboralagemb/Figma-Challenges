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
    @State var textFieldEntry: String = ""
    
    init(){
        for family in UIFont.familyNames {
             print(family)
             for names in UIFont.fontNames(forFamilyName: family){
             print("== \(names)")
             }
        }
    }
    
    var body: some View {
        VStack {
            buttonsView
            
            Text("How was your shopping experience?")
                .font(Font.custom("Poppins-Medium", size: 20))
                .fontWeight(.medium)
                .foregroundStyle(secondaryColor)
                .padding(.vertical, 30)
                .padding(.horizontal, 50)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            faceView
            
            Spacer()
            
            experienceTextView
            
            Spacer()
            
//            sliderView
//
//            CustomSliderView(value: $currentValue, 
//                             userExperience: $userExperience,
//                             mouthDegree: $mouthDegree)
//            
////            Slider(value: $currentValue, in: 0...2)
//            
//            bottomButtonsView
            
            addNoteTextField
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
                    .resizable()
                    .foregroundStyle(secondaryColor)
                    .frame(width: 18, height: 18)
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
                    .resizable()
                    .foregroundStyle(secondaryColor)
                    .frame(width: 22, height: 22)
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
                .rotationEffect(.degrees(areEyesSpinning ? -45 : 0))
                .animation(.easeInOut(duration: 0.5), value: areEyesSpinning)
            
            Capsule(style: .circular)
                .frame(width: eyeFrame.width, height: eyeFrame.height)
                .rotationEffect(.degrees(areEyesSpinning ? 45 : 0))
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
    
    var bottomButtonsView: some View {
        ZStack {
            addNoteButtonView
            
            HStack {
                Spacer(minLength: 150)
                
                submitButtonView
            }
        }.padding(.horizontal, 20)
    }
    
    var addNoteButtonView: some View {
        ZStack(alignment: .leading) {
            Capsule(style: .circular)
                .frame(height: 54)
                .foregroundStyle(tertiaryColor)
            
            Text("Add note")
                .font(Font.custom("Inter", size: 16))
                .fontWeight(.medium)
                .foregroundStyle(secondaryColor)
                .padding(.leading, 30)
        }
    }
    
    var submitButtonView: some View {
        ZStack {
            Capsule(style: .circular)
                .frame(height: 54)
                .foregroundStyle(secondaryColor)
            
            HStack(/*alignment: .center, */spacing: 11) {
                Text("Submit")
                    .font(Font.custom("Inter", size: 16))
                    .fontWeight(.medium)
                    .foregroundStyle(tertiaryColor)
                
                Image(systemName: "arrow.right")
                    .renderingMode(.template)
                    .resizable()
                    .foregroundStyle(tertiaryColor)
                    .frame(width: 13, height: 9)
            }
        }
    }
    
    var addNoteTextField: some View {
        VStack {
            TextField("Add note", text: $textFieldEntry)
                .foregroundStyle(primaryColor.opacity(0.4))
                .padding(16)
            
            HStack {
                Spacer(minLength: 150)
                
                submitButtonView
                    .padding(10)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(tertiaryColor)
                .stroke(secondaryColor.opacity(0.4), lineWidth: 2)
        )
        .padding(.horizontal, 40)
    }
}

#Preview {
    ContentView()
}

