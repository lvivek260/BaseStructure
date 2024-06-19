//
//  DropdownTextfield.swift
//  DropDownTextField
//
//  Created by PHN MAC 1 on 08/02/24.
//

// MARK: - How to use
/*
 @IBOutlet weak var dropDownTextField: DropdownTextField!
 dropDownTextField.options = ["Vivek", "Pavan", "Ravi", "Shivam", "Sunam", "Disha"]
 dropDownTextField.text = "Pavan"
 */

import UIKit

protocol DropdownTextFieldDelegate: AnyObject {
    func dropdownTextField(
        _ dropdownTextField: DropdownTextField,
        didSelectOption option: String,
        atIndex index: Int
    )
}

class DropdownTextField: CustomTextField{
    // MARK: - Properties
    private let pickerView = UIPickerView()
    weak var dropdownDelegate: DropdownTextFieldDelegate?
    
    var options: [String] = [] {
        didSet {
            pickerView.reloadAllComponents()
            selectDefaultOption()
        }
    }
    override var text: String?{
        didSet{
            selectDefaultOption()
        }
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        pickerView.delegate = self
        pickerView.dataSource = self
        inputView = pickerView
        delegate = self
        
        createToolBar()
        selectDefaultOption()
    }
    
    private func createToolBar(){
        // Customize toolbar
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([cancelButton, flexibleSpace, doneButton], animated: false)
        inputAccessoryView = toolbar
    }
    
    @objc private func cancelButtonTapped() {
        resignFirstResponder()
    }
    @objc private func doneButtonTapped() {
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        if selectedRow <= options.count-1{
            let selectedValue = options[selectedRow] // Assuming pickerViewData is an array of strings
            text = selectedValue
            dropdownDelegate?.dropdownTextField(self, didSelectOption: selectedValue, atIndex: selectedRow)
        }
        resignFirstResponder()
    }
}

// MARK: - UIPicker View Delegate and DataSource
extension DropdownTextField: UIPickerViewDelegate, UIPickerViewDataSource{
    private func selectDefaultOption() {
        guard let text = text, let index = options.firstIndex(of: text) else { return }
        pickerView.selectRow(index, inComponent: 0, animated: false)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }
}

// MARK: - UITextFieldDelegate
extension DropdownTextField{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
