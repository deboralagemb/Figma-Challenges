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
    
    @StateObject var viewModel = ContentViewModel()
    @FocusState var isFocused: Bool
    @State var isEditing: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            buttonsView
            
            if !isEditing && !viewModel.feedbackSubmitted {
                mainTitleView
                
                Spacer()
            }
            
            if viewModel.feedbackSubmitted {
                Spacer()
                    .frame(height: 50)
            }
            
            faceView
                .padding(.vertical, isEditing ? 30 : 0)
            
            if !isEditing && !viewModel.feedbackSubmitted {
                Spacer()
                
                experienceTextView
                
                Spacer()
                
                CustomSliderButtonView()
                
                bottomButtonsView
            }
            
            if viewModel.feedbackSubmitted {
                thanksForFeedbackView
                    .transition(.move(edge: .bottom))
            }
            
            if isEditing {
                addNoteTextField
                    .animation(.easeInOut(duration: 0.3), value: isEditing)
                
                Spacer()
                    .animation(.easeInOut(duration: 0.3), value: isEditing)
            }
        }
        .padding()
        .background(viewModel.primaryColor)
        .environmentObject(viewModel)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    var buttonsView: some View {
        HStack {
            Button {
                isFocused = false
                isEditing = false
            } label: {
                Image(systemName: "xmark")
                    .renderingMode(.template)
                    .resizable()
                    .foregroundStyle(viewModel.secondaryColor)
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
                    .foregroundStyle(viewModel.secondaryColor)
                    .frame(width: 22, height: 22)
            }
            .frame(width: 54, height: 54)
            .background(Color.black.opacity(0.05))
            .clipShape(Circle())
        }
    }
    
    var mainTitleView: some View {
        Text("How was your shopping experience?")
            .font(Font.custom("Poppins-Medium", size: 20))
            .fontWeight(.medium)
            .foregroundStyle(viewModel.secondaryColor)
            .padding(.vertical, 30)
            .padding(.horizontal, 50)
            .multilineTextAlignment(.center)
    }
    
    var faceView: some View {
        VStack(spacing: 0) {
            eyesView
            mouthView
        }
    }
    
    var eyesView: some View {
        HStack(spacing: viewModel.eyeSpacing) {
            Capsule(style: .circular)
                .frame(width: viewModel.eyeFrame.width, height: viewModel.eyeFrame.height)
                .rotationEffect(.degrees(-viewModel.eyesDegree))
                .animation(.easeInOut(duration: 0.5), value: viewModel.areEyesSpinning)
            
            Capsule(style: .circular)
                .frame(width: viewModel.eyeFrame.width, height: viewModel.eyeFrame.height)
                .rotationEffect(.degrees(viewModel.eyesDegree))
                .animation(.easeInOut(duration: 0.5), value: viewModel.areEyesSpinning)
        }
        .foregroundStyle(viewModel.secondaryColor)
    }
    
    var mouthView: some View {
        SemiCircumferenceShape()
            .rotation(Angle(degrees: viewModel.mouthDegree))
            .stroke(viewModel.secondaryColor, style: StrokeStyle(lineWidth: 20, lineCap: .round))
            .frame(width: 75, height: 50)
    }
    
    var experienceTextView: some View {
        ScrollViewReader { scrollProxy in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 10) {
                    ForEach(viewModel.range, id: \.self) { index in
                        Text(viewModel.experienceText[index].uppercased())
                            .font(Font.system(size: 64, weight: .black))
                            .kerning(-4)
                            .foregroundStyle(viewModel.textColor)
                    }
                    .containerRelativeFrame(.horizontal)
                }
                .scrollTargetLayout()
            }
            .contentMargins(.horizontal, 10, for: .scrollContent)
            .scrollTargetBehavior(.viewAligned)
            .frame(height: 100)
            .onChange(of: viewModel.targetIndex) {
                withAnimation(.interpolatingSpring(stiffness: 50, damping: 5)) {
                    scrollProxy.scrollTo(viewModel.targetIndex, anchor: .center)
                }
            }
            .onAppear {
                scrollProxy.scrollTo(viewModel.targetIndex, anchor: .center)
            }
        }
    }
    
    var bottomButtonsView: some View {
        ZStack {
            secondaryButtonView
            
            HStack {
                Spacer(minLength: 150)
                
                primaryButtonView
            }
        }
        .padding(.horizontal, 30)
        .padding(.top, 50)
    }
    
    var secondaryButtonView: some View {
        Button {
            withAnimation {
                isFocused = true
                isEditing = true
            }
        } label: {
            HStack {
                Text("Add note")
                    .font(Font.custom("Inter 18pt", size: 16))
                    .fontWeight(.medium)
                    .padding(.leading, 16)
                Spacer()
            }
        }
        .padding()
        .background(viewModel.tertiaryColor)
        .foregroundStyle(viewModel.secondaryColor)
        .clipShape(Capsule())
        .frame(height: 54)
    }
    
    var primaryButtonView: some View {
        Button {
            withAnimation {
                viewModel.feedbackSubmitted.toggle()
                if !viewModel.feedbackSubmitted { isEditing = false }
            }
        } label: {
            HStack(spacing: 11) {
                Spacer()
                Text(viewModel.primaryButtonViewText)
                    .font(Font.custom("Inter 18pt", size: 16))
                    .fontWeight(.medium)
                
                Image(systemName: "arrow.right")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 13, height: 9)
                
                Spacer()
            }
        }
        .padding()
        .background(viewModel.secondaryColor)
        .foregroundStyle(viewModel.tertiaryColor)
        .clipShape(Capsule())
        .frame(height: 54)
    }
    
    var addNoteTextField: some View {
        VStack {
            
            if !viewModel.feedbackSubmitted {
                TextField("Add note", text: $viewModel.textFieldEntry)
                    .focused($isFocused)
                    .foregroundStyle(viewModel.secondaryColor)
                    .padding(16)
            }
            
            HStack(spacing: .zero) {
                if !viewModel.feedbackSubmitted {
                    Spacer(minLength: 130)
                }
                
                primaryButtonView
                    .padding(10)
            }
        }
        .if(!viewModel.feedbackSubmitted, transform: { vstack in
            vstack
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(viewModel.tertiaryColor)
                        .stroke(viewModel.secondaryColor.opacity(0.4), lineWidth: 3)
                )
        })
        .padding(.top, viewModel.feedbackSubmitted ? 10 : 30)
        .padding(.horizontal, 30)
    }
    
    var thanksForFeedbackView: some View {
        VStack(spacing: 18) {
            Spacer()
            
            Text(viewModel.feedbackSubmittedTitle)
                .font(Font.system(size: 33, weight: .black))
                .foregroundStyle(viewModel.secondaryColor)
                .multilineTextAlignment(.center)
            
            Text(viewModel.feedbackSubmittedSubtitle)
                .font(Font.custom("Poppins-Medium", size: 18))
                .fontWeight(.medium)
                .foregroundStyle(viewModel.secondaryColor)
                .multilineTextAlignment(.center)
            
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
