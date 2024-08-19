//
//  ContentViewModel.swift
//  FigmaChallenge
//
//  Created by Débora Lage on 15/08/24.
//

import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var userExperience: Experience = .notBad
    @Published var targetIndex: Int = 1
    @Published var mouthDegree: Double = 270
    @Published var eyeFrame: (width: CGFloat?, height: CGFloat) = (103, 38)
    @Published var eyeSpacing: Double = 20
    @Published var areEyesSpinning: Bool = false
    @Published var textFieldEntry: String = ""
    @Published var currentValue = 1
    @Published var feedbackSubmitted = false
    @Published var eyesDegree: Double = 0

    // MARK: - Computed Properties
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
    
    var feedbackSubmittedTitle: String {
        switch userExperience {
        case .bad, .notBad:
            return "Thank you for your feedback!"
        case .good:
            return "Thanks for your feedback!"
        }
    }
    
    var feedbackSubmittedSubtitle: String {
        switch userExperience {
        case .bad:
            return "We're sorry to hear that. We're working hard to improve!"
        case .notBad:
            return "We appreciate your input and are always looking to improve!"
        case .good:
            return "We're glad you had a great experience!"
        }
    }
    
    var primaryButtonViewText: String {
        feedbackSubmitted ? "Continue my shopping" : "Submit"
    }
    
    // MARK: - Variables
    var experienceText: [String] = ["Bad", "Not bad", "Good"]
    var range: ClosedRange<Int> = 0...2
    
    // MARK: - Methods
    func badButtonPressed() {
        eyeFrame = (60, 60)
        eyeSpacing = 40
        mouthDegree = 270
        targetIndex = 0
        eyesDegree = 45
        if userExperience == .notBad {
            areEyesSpinning.toggle()
        }
        userExperience = .bad
    }
    
    func notBadButtonPressed() {
        eyeFrame = (103, 38)
        eyeSpacing = 20
        mouthDegree = 270
        targetIndex = 1
        eyesDegree = 0
        if userExperience == .bad {
            areEyesSpinning.toggle()
        }
        userExperience = .notBad
    }
    
    func goodButtonPressed() {
        eyeFrame = (128, 128)
        eyeSpacing = 16
        mouthDegree = 90
        targetIndex = 2
        if userExperience == .bad { areEyesSpinning.toggle() }
        userExperience = .good
    }
    
    func sliderTextColor(_ isSelected: Bool) -> Color {
        isSelected ? secondaryColor : tertiaryColor
    }
}
