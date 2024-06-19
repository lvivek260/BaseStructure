//
//  CheckBoxButton.swift
//  LMS
//
//  Created by PHN MAC 1 on 01/02/24.
//


import UIKit

class CheckBox: UIButton {
    let checkedImage:UIImage = UIImage()
    let uncheckedImage:UIImage = UIImage()
    
    var radioBtnCheckedHandler: (()->Void)?
    var radioBtnUncheckedHandler: (() -> Void)?
    
    // Bool property
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                self.setImage(checkedImage, for: UIControl.State.normal)
                radioBtnCheckedHandler?()
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
                radioBtnUncheckedHandler?()
            }
        }
    }
        
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
        
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
