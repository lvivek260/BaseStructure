//
//  GradientView.swift
//  LMS
//
//  Created by PHN MAC 1 on 22/02/24.
//


import UIKit

final class GradientImageView: UIImageView{
    override func layoutSubviews() {
        let startPoint = CGPoint(x: 0.5, y: 0.5) // Top center
        let endPoint = CGPoint(x: 0.5, y: 1.0) // Bottom center
        self.addGradient(colors: [.clear, .black], startPoint: startPoint, endPoint: endPoint, cornerRadius: 0.0)
    }
}
