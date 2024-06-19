//
//  CustomSegment.swift
//  LMS
//
//  Created by PHN MAC 1 on 31/01/24.
//

import UIKit

class CustomSegmentedControl: UISegmentedControl {

    private let selectedAttributes: [NSAttributedString.Key : Any] = [
        .foregroundColor: UIColor.white,
        .font : UIFont(name: "Poppins-SemiBold", size: 14) as Any
    ]

    private let unSelectedAttributes: [NSAttributedString.Key : Any] = [
        .foregroundColor: UIColor.black,
        .font : UIFont(name: "Poppins-Regular", size: 14) as Any
    ]

    override init(items: [Any]?) {
        super.init(items: items)
        setupAppearance()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAppearance()
    }

    private func setupAppearance() {
        setTitleTextAttributes(selectedAttributes, for: .selected)
        setTitleTextAttributes(unSelectedAttributes, for: .normal)
    }
}
