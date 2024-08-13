//
//  SemiCircumferenceShape.swift
//  FigmaChallenge
//
//  Created by Débora Lage on 13/08/24.
//

import SwiftUI

struct SemiCircumferenceShape: Shape {
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
