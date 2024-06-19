//
//  s.swift
//  PHN Inventory
//
//  Created by PHN MAC 1 on 07/06/24.
//

import UIKit

class CustomScrollView: UIScrollView {

    var nonScrollableView: UIView?

    override func touchesShouldCancel(in view: UIView) -> Bool {
        if let nonScrollableView = nonScrollableView, view.isDescendant(of: nonScrollableView) {
            return false
        }
        return super.touchesShouldCancel(in: view)
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        if let nonScrollableView = nonScrollableView, let hitView = hitView, hitView.isDescendant(of: nonScrollableView) {
            self.isScrollEnabled = false
        } else {
            self.isScrollEnabled = true
        }
        return hitView
    }
}
