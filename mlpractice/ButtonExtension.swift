//
//  ButtonExtension.swift
//  mlpractice
//
//  Created by David Nyman on 9/7/18.
//  Copyright © 2018 David. All rights reserved.
//

import UIKit

@IBDesignable

extension UIColor {
    static let skinnoGreen = UIColor(red:0.71, green:0.92, blue:0.74, alpha:1.0)
    static let skinnoBlue = UIColor(red:0.11, green:0.25, blue:0.42, alpha:1.0)
    static let skinnoTan = UIColor(red:0.93, green:0.77, blue:0.58, alpha:1.0)
    static let skinnoBrown = UIColor(red:0.31, green:0.16, blue:0.04, alpha:1.0)
    static let skinnoRed = UIColor(red:1.00, green:0.40, blue:0.27, alpha:1.0)
    
}

class BarcodeButton: UIButton {
    override var isSelected: Bool {
        didSet {
            tintColor = isSelected ? .skinnoBlue : .white
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.backgroundColor = UIColor.white.cgColor
        setTitleColor(UIColor.skinnoBlue, for: .normal)
        setTitleColor(UIColor.white, for: .selected)
    }
}

class NavButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .skinnoGreen : .white
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? .skinnoGreen : .white
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.backgroundColor = UIColor.skinnoBlue.cgColor
        setTitleColor(UIColor.skinnoBlue, for: .normal)
        setTitleColor(UIColor.skinnoGreen, for: .selected)
        layer.borderColor = UIColor.skinnoBlue.cgColor
        layer.backgroundColor = UIColor.white.cgColor
        layer.borderWidth = 2.2
    }
}
