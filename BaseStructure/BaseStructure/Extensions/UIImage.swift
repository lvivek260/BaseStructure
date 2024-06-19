//
//  UIImage.swift
//  LMS
//
//  Created by PHN Tech 2 on 24/01/24.
//

import Foundation
import UIKit

//MARK: Extension of UIImage to generate the image users first name and last name initials
extension UIImage {
    convenience init?(firstName: String, lastName: String? = "", size: CGSize = CGSize(width: 100, height: 100), backgroundColor: UIColor = .lightGray, textColor: UIColor = .white, font: UIFont = UIFont.systemFont(ofSize: 30, weight: .bold)) {
        
        let initials = "\(firstName.first ?? " ")"
        
        let frame = CGRect(origin: .zero, size: size)
        let imageView = UIImageView(frame: frame)
        imageView.backgroundColor = backgroundColor
        imageView.layer.cornerRadius = size.width / 2
        imageView.clipsToBounds = true
        
        let label = UILabel(frame: frame)
        label.text = initials
        label.textColor = textColor
        label.textAlignment = .center
        label.font = font
        
        imageView.addSubview(label)
        
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        imageView.layer.render(in: context)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        
        self.init(cgImage: image.cgImage!, scale: UIScreen.main.scale, orientation: image.imageOrientation)
    }
}
