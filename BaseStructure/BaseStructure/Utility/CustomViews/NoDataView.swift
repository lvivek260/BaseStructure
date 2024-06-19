//
//  NoDataView.swift
//  PHN Inventory
//
//  Created by PHN MAC 1 on 04/06/24.
//

import UIKit

class NoDataView: UIView {
    @IBOutlet private var containerView: UIView!
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var lblMessage: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commitInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commitInit()
    }
    
    private func commitInit(){
        Bundle.main.loadNibNamed(NoDataView.id, owner: self,options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [ .flexibleHeight, .flexibleWidth ]
    }
    
    func setData(_ message: String? = nil,_ image: UIImage? = nil){
        if let message, message != ""{
            lblMessage.text = message
        }
        if let image{
            imageView.image = image
        }
    }
}
