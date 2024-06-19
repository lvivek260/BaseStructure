//
//  SignatureView.swift
//  PHN Inventory
//
//  Created by PHN MAC 1 on 06/06/24.
//

import UIKit

class SignatureView: UIView {

    private var path = UIBezierPath()
    private var previousPoint: CGPoint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
       // backgroundColor = .system
        path.lineWidth = 5.0
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        previousPoint = touch.location(in: self)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let previousPoint = previousPoint else { return }
        let currentPoint = touch.location(in: self)
        path.move(to: previousPoint)
        path.addLine(to: currentPoint)
        self.previousPoint = currentPoint
        setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {
        UIColor.black.setStroke()
        path.stroke()
    }

    func clear() {
        path.removeAllPoints()
        setNeedsDisplay()
    }

    func getSignatureImage() -> UIImage? {
        // Check if the path contains any points
        guard !path.isEmpty else {
            // Return nil or a default empty image if the path is empty
            return nil
        }
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        self.backgroundColor?.setFill()
        context.fill(bounds)
        UIColor.black.setStroke()
        path.stroke()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

}
