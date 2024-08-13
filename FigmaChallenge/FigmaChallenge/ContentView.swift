//
//  ContentView.swift
//  FigmaChallenge
//
//  Created by Débora Lage on 13/08/24.
//

import SwiftUI

enum Experience {
    case bad
    case notBad
    case good
}

struct ContentView: View {
    
    @State var userExperience: Experience = .notBad
    @State private var currentValue = 1.0
    var backgroundColor: Color {
        switch userExperience {
        case .bad:
            return .red
        case .notBad:
            return .yellow
        case .good:
            return .green
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
    @State var eyeFrame: (width: CGFloat?, height: CGFloat) = (nil, 50)
    
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

//            CustomSliderView(value: $currentValue)
            
            Slider(value: $currentValue, in: 0...2)
        }
        .padding()
        .background(backgroundColor)
    }
    
    var buttonsView: some View {
        HStack {
            Button {
                print("xmark button tapped")
            } label: {
                Image(systemName: "xmark")
                    .renderingMode(.template)
                    .foregroundStyle(.black)
            }
            .frame(width: 50, height: 50)
            .background(.ultraThinMaterial)
            .clipShape(Circle())
            
            Spacer()
            
            Button {
                print("xmark button tapped")
            } label: {
                Image(systemName: "info.circle")
                    .renderingMode(.template)
                    .foregroundStyle(.black)
            }
            .frame(width: 50, height: 50)
            .background(.ultraThinMaterial)
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
        HStack(spacing: 40) {
            Capsule(style: .circular)
                .frame(width: eyeFrame.width, height: eyeFrame.height)
            
            Capsule(style: .circular)
                .frame(width: eyeFrame.width, height: eyeFrame.height)
        }
    }
    
    var mouthView: some View {
        SemiCircleShape()
            .rotation(Angle(degrees: mouthDegree))
            .stroke(Color.black, style: StrokeStyle(lineWidth: 20, lineCap: .round))
            .frame(width: 75, height: 50)
//            .animation(.easeOut(duration: 1.0), value: mouthDegree)
    }
    
    var experienceTextView: some View {
        Text(experienceText.uppercased())
            .font(.largeTitle)
            .fontWeight(.heavy)
    }
    
    var sliderView: some View {
        HStack {
            Button {
                withAnimation(.bouncy) {
                    eyeFrame = (50, 50)
                    mouthDegree = 270
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
                    eyeFrame = (nil, 50)
                    mouthDegree = 270
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
                    eyeFrame = (150, 150)
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
}

#Preview {
    ContentView()
}

struct SemiCircleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.addArc(center: CGPoint(x: rect.minX, y: rect.midY),
                    radius: rect.width / 2,
                    startAngle: .degrees(-45),
                    endAngle: .degrees(45),
                    clockwise: false)
        
        return path
    }
}
