//
//  GameButton.swift
//  TheNameGame
//
//  Created by Lynk on 3/22/21.
//

import UIKit

@IBDesignable
class GameButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
       didSet {
           layer.cornerRadius = cornerRadius
           layer.masksToBounds = cornerRadius > 0
       }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        layer.cornerCurve = .continuous
    }
}
