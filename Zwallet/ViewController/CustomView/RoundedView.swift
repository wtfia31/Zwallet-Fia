//
//  RoundedView.swift
//  Zwallet
//
//  Created by DDL13 on 09/08/23.
//

import UIKit

class RoundedView: UIView {

    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            update()
        }
    }
    
    override func prepareForInterfaceBuilder() { 
        super.prepareForInterfaceBuilder()
        update()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        update()
    }
    
    func update() {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }


}
