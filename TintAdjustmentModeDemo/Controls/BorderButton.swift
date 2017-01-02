//
//  BorderButton.swift
//  TintAdjustmentModeDemo
//
//  Created by Wayne Hartman on 1/2/17.
//  Copyright © 2017 Wayne Hartman. All rights reserved.
//

import UIKit

class BorderButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()

        self.layer.borderColor = self.tintColor.cgColor
        self.layer.borderWidth = 1.0 / UIScreen.main.scale
        self.layer.cornerRadius = self.frame.size.height * 0.5;
    }

    override func tintColorDidChange() {
        super.tintColorDidChange()

        self.layer.borderColor = self.tintColor.cgColor;
    }
}
