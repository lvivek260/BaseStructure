//
//  CustomTextField.swift
//  LMS
//
//  Created by PHN Tech 2 on 31/01/24.
//

import UIKit

class CustomTextField: UITextField {
    
    // MARK: - Properties
    private let topLeftLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont(name: "Poppins", size: 12)
        label.backgroundColor = .white
        return label
    }()
    
    // Set padding for text within the text field
    private var padding = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    
    // Set corner radius for the text field
    @IBInspectable var cornerRadius: CGFloat = 8.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    // Set text for the label at the top left corner
    @IBInspectable
    var topLeftLabelText: String? {
        didSet {
            topLeftLabel.text = topLeftLabelText
        }
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override var text: String?{
        didSet{
            if let newText = text {
                #if DEBUG
                print("Text changed: \(newText)")
                #endif
                topLeftLabel.isHidden = newText.count == 0
                // Perform additional actions based on the changed text
            }
        }
    }
    
    override var isEnabled: Bool{
        didSet{
            if !isEnabled{
                self.backgroundColor = .gray
            }else{
                self.backgroundColor = .systemBackground
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        delegate = self
        layer.cornerRadius = 22
        addSubview(topLeftLabel)
        topLeftLabel.isHidden = (self.text ?? "").count == 0
    }
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Set frame for the label at the top left corner
        let labelHeight: CGFloat = 20
        topLeftLabel.frame = CGRect(x: 20,
                                    y: -10,
                                    width: (topLeftLabel.intrinsicContentSize.width + 10),
                                    height: labelHeight)
    }
    
    // MARK: - Text Rect
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    // MARK: - Editing Rect
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    // MARK: - Placeholder Rect
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

extension CustomTextField : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        topLeftLabel.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        topLeftLabel.isHidden = (textField.text ?? "").count == 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
