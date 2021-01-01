//
//  UIViewDesignable.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 12/25/20.
//  Copyright © 2020 AtomicHabit. All rights reserved.
//

import UIKit

@IBDesignable
class ContainerView: UIView {
    @IBInspectable public var cornerRadius: CGFloat = 15.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
}
//extension UIView {
//    @IBInspectable var cornerRadius: CGFloat {
//        get {
//            return layer.cornerRadius
//        }
//        set {
//            layer.cornerRadius = newValue
//            layer.masksToBounds = newValue > 0
//        }
//    }
//}
