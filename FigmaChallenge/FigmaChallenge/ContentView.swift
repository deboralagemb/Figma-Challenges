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
    @FocusState var isEditingText: Bool {
        didSet {
            viewModel.isDefaultState = isEditingText
        }
    }

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
            
            if viewModel.isDefaultState {
                Text("How was your shopping experience?")
                    .font(Font.custom("Poppins-Medium", size: 20))
                    .fontWeight(.medium)
                    .foregroundStyle(viewModel.secondaryColor)
                    .padding(.vertical, 30)
                    .padding(.horizontal, 50)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
            
            faceView
                .padding(.vertical, viewModel.isDefaultState ? 0 : 30)
            
            if viewModel.isDefaultState {
                Spacer()
                
                experienceTextView
                
                Spacer()
                
                CustomSliderButtonView()
                
                bottomButtonsView
            }
            
            if !viewModel.isDefaultState {
                addNoteTextField

                Spacer()
            }
        }
        .padding()
        .background(viewModel.primaryColor)
        .environmentObject(viewModel)
        .onTapGesture {
            isEditingText = false
        }
    }
    
    var buttonsView: some View {
        HStack {
            Button {
                print("xmark button tapped")
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
    
    var faceView: some View {
        VStack(spacing: 0) {
            eyesView
            mouthView
        }/*.frame(height: 200)*/
    }
    
    var eyesView: some View {
        HStack(spacing: viewModel.eyeSpacing) {
            Capsule(style: .circular)
                .frame(width: viewModel.eyeFrame.width, height: viewModel.eyeFrame.height)
                .rotationEffect(.degrees(viewModel.areEyesSpinning ? -45 : 0))
                .animation(.easeInOut(duration: 0.5), value: viewModel.areEyesSpinning)
            
            Capsule(style: .circular)
                .frame(width: viewModel.eyeFrame.width, height: viewModel.eyeFrame.height)
                .rotationEffect(.degrees(viewModel.areEyesSpinning ? 45 : 0))
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
                       // Adjust the scroll position slightly to simulate a bounce
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
            addNoteButtonView
            
            HStack {
                Spacer(minLength: 150)
                
                submitButtonView
            }
        }
        .padding(.horizontal, 30)
        .padding(.top, 50)
    }
    
    var addNoteButtonView: some View {
        Button {
            isEditingText = true
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
    
    var submitButtonView: some View {
        Button {
            print("Submit button pressed")
        } label: {
            HStack(spacing: 11) {
                Text("Submit")
                    .font(Font.custom("Inter 18pt", size: 16))
                    .fontWeight(.medium)
                
                Image(systemName: "arrow.right")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 13, height: 9)
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
            TextField("Add note", text: $viewModel.textFieldEntry)
                .focused($isEditingText)
                .foregroundStyle(viewModel.primaryColor.opacity(0.4))
                .padding(16)
            
            HStack {
                Spacer(minLength: 150)
                
                submitButtonView
                    .padding(10)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(viewModel.tertiaryColor)
                .stroke(viewModel.secondaryColor.opacity(0.4), lineWidth: 2)
        )
        .padding(.top, 30)
        .padding(.horizontal, 30)
    }
}

#Preview {
    ContentView()
}

