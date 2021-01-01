//
//  StandardButton.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 12/10/20.
//  Copyright © 2020 AtomicHabit. All rights reserved.
//

import UIKit

@IBDesignable
class StandardButton: UIButton {

    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.

    */
    
    @IBInspectable public var titleColor: UIColor = UIColor.white {
        didSet {
            self.setTitleColor(titleColor, for: .normal)
        }
    }
    
    @IBInspectable public var borderColor: CGColor = UIColor.clear.cgColor {
        didSet {
            self.layer.borderColor = borderColor
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable public var shadowColor: UIColor = UIColor(red: (44/255) - 0.1, green: (126/255) - 0.1, blue: (181/255) - 0.1, alpha: 1.0)
    {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable public var shadowOffset: CGSize = CGSize(width:0.0, height: 2.0) {
        didSet {
            self.layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable public var shadowOpacity: Float = 1.0 {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable public var shadowRadius: Float = 2.0 {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 8.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func didMoveToWindow() {
        // Drawing code
        self.backgroundColor = UIColor(red: 44/255, green: 126/255, blue: 181/255, alpha: 1.0)
        self.setTitleColor(UIColor.white, for: .normal)
        
        self.layer.borderWidth = 2.0;
        self.layer.borderColor = UIColor.clear.cgColor
        
        self.layer.shadowColor = UIColor(red: (44/255) - 0.1, green: (126/255) - 0.1, blue: (181/255) - 0.1, alpha: 1.0).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 2.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 8.0
                
    }

}
