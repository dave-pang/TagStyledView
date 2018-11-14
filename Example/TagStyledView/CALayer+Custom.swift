//
//  CALayer+Custom.swift
//  TagStyledView_Example
//
//  Created by Dave on 09/11/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

extension CALayer {
    @IBInspectable
    var borderUIColor: UIColor? {
        set {
            borderColor = newValue?.cgColor
        }
        get {
            if let color = borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
    }
}
