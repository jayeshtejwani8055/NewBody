//
//  OtherMethod.swift
//  DemoTapPopUp
//
//  Created by Jayesh Tejwani on 05/01/22.
//

import Foundation
import UIKit

class JTNeumorphicView: UIView {
    @IBInspectable var cornerRadious: CGFloat = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = cornerRadious == 0 ? (self.frame.height) / 2 : cornerRadious
        self.layer.masksToBounds = true
    }
}

let _screenSize     = UIScreen.main.bounds.size
