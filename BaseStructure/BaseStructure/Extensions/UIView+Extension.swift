//
//  UIView+Extension.swift
//  LMS
//
//  Created by PHN MAC 1 on 08/01/24.
//

import UIKit

extension UIView{
    
    func addGradient(
        colors: [UIColor],
        startPoint: CGPoint = CGPoint(x: 0, y: 0),
        endPoint: CGPoint = CGPoint(x: 1, y: 1),
        cornerRadius: CGFloat
    ){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.frame
        
        gradientLayer.colors = colors .map{ $0.cgColor } // Customize the colors as needed
       
        // Optionally, you can set other properties like the start and end points
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
       // gradientLayer.position = self.center
        gradientLayer.cornerRadius = cornerRadius
        
        // Add the gradient layer to the view's layer
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

// MARK: - Add Border, Corner
extension UIView{
    func addBorder(cornerRadius: CGFloat = 0, borderWidth: CGFloat = 1, borderColor: UIColor){
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11, *) {
            self.clipsToBounds = true
            self.layer.cornerRadius = radius
            var masked = CACornerMask()
            if corners.contains(.topLeft) { masked.insert(.layerMinXMinYCorner) }
            if corners.contains(.topRight) { masked.insert(.layerMaxXMinYCorner) }
            if corners.contains(.bottomLeft) { masked.insert(.layerMinXMaxYCorner) }
            if corners.contains(.bottomRight) { masked.insert(.layerMaxXMaxYCorner) }
            self.layer.maskedCorners = masked
        }
        else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
}
