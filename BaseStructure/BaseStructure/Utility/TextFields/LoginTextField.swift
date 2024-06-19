//
//  LoginTextField.swift
//  LMS
//
//  Created by PHN MAC 1 on 05/01/24.
//

import UIKit

class LoginTextField: UITextField{
    
 private var isPasswordMode: Bool = true
 private var eyeIconView: UIImageView =  UIImageView()
    
// MARK: - Default Fuctions
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTextField()
    }
    
// MARK: - Configurations
    private func setupTextField() {
        // Add your custom styling here
        layer.cornerRadius = 22.0
        layer.masksToBounds = true
        layer.borderColor = UIColor.systemGray5.cgColor
        layer.borderWidth = 1.0
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.height))
        leftView = paddingView
        leftViewMode = .always
        delegate = self
    }
    
    func setPasswordConfiguration() {
        // Container view for right padding
        let paddingContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: self.frame.height))
        
        // Configure right view for password visibility toggle
        eyeIconView = UIImageView(image: UIImage(systemName: "eye"))
        eyeIconView.tintColor = UIColor.systemGray3
        eyeIconView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(passwordHideShow))
        eyeIconView.addGestureRecognizer(tapGesture)
        
        // Set initial frame for eye icon
        eyeIconView.frame = CGRect(x: 0, y: 0, width: 28, height: 22)
        eyeIconView.contentMode = .scaleToFill
        eyeIconView.center = paddingContainerView.center
        // Add the eye icon to the container view
        paddingContainerView.addSubview(eyeIconView)
        
        rightView = paddingContainerView
        rightViewMode = .always
    }
    @objc private func passwordHideShow(){
        isPasswordMode.toggle()
        isSecureTextEntry = isPasswordMode
        let eyeIconName = isPasswordMode ? "eye" : "eye.slash"
        eyeIconView.image = UIImage(systemName: eyeIconName)
    }
}

// MARK: - UITextField Delegate Methods
extension LoginTextField: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismiss the keyboard when return key is tapped
        textField.resignFirstResponder()
        return true
    }
}
