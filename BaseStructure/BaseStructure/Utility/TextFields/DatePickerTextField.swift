//
//  DatePickerTextField.swift
//  LMS
//
//  Created by PHN MAC 1 on 12/02/24.
//

import UIKit

protocol DatePickerTextFieldDelegate: AnyObject {
    func datePickerTextField(
        _ dropdownTextField: DatePickerTextField,
        didSelectDate date: Date
    )
}

class DatePickerTextField: CustomTextField {
    var datePicker: UIDatePicker!
    private var toolbar: UIToolbar!
    weak var datePickerDelegate: DatePickerTextFieldDelegate?
    var dateFormatter = DateFormatter()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDatePicker()
        setupToolbar()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupDatePicker()
        setupToolbar()
    }
    
    func setDefaultDate(dateStr: String?, dateFormat: String){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat  // Adjust the format according to your date string
        
        // Convert the date string to a Date object
        if let defaultDate = dateFormatter.date(from: dateStr ?? "") {
            // Set the default date for the datePicker
            datePicker.setDate(defaultDate, animated: true)
        }
    }

    private func setupDatePicker() {
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        inputView = datePicker
    }

    private func setupToolbar() {
        toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([cancelButton, flexibleSpace, doneButton], animated: false)
        inputAccessoryView = toolbar
    }

    @objc private func cancelButtonTapped() {
        resignFirstResponder()
    }

    @objc private func doneButtonTapped() {
        text = dateFormatter.string(from: datePicker.date)
        datePickerDelegate?.datePickerTextField(self, didSelectDate: datePicker.date)
        resignFirstResponder()
    }
}

// MARK: - UITextFieldDelegate
extension DatePickerTextField{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
