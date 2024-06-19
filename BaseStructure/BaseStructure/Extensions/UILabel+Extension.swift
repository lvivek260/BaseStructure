//
//  UILabel+Extension.swift
//  LMS
//
//  Created by PHN MAC 1 on 11/01/24.
//

import UIKit

extension UILabel{
    func setSupportLink(){
        let textstr = "Don’t have an account? Connect us at \nsupport@phntechnology.com"
        self.text = textstr
        let colorAttriString = NSMutableAttributedString(string: textstr)
        let emailRange = (textstr as NSString).range(of: "support@phntechnology.com")
        colorAttriString.addAttribute(.foregroundColor, value: UIColor.red, range: emailRange)
        self.attributedText = colorAttriString
        if let customFont = UIFont(name: "Poppins-Regular", size: 12.0) {
            self.font = customFont
        }
        //add gesture Recognizer on email
        let tapAction = UITapGestureRecognizer(target: self, action: #selector(self.openEmail(gesture:)))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapAction)
    }
    
    
    //open support email
    @objc private func openEmail(gesture: UITapGestureRecognizer){
        print("openEmail function called")
        let emailRange = ((self.text ?? "") as NSString).range(of: "\nsupport@phntechnology.com")
        if gesture.didTapAttributedTextInLabel(label: self, inRange: emailRange) {
            if let emailURL = URL(string: "https://phntechnology.com/") {
                UIApplication.shared.open(emailURL)
            }
        }
        
    }
}
