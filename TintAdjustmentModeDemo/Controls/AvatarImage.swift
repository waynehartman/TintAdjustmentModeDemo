//
//  AvatarImage.swift
//  TintAdjustmentModeDemo
//
//  Created by Wayne Hartman on 1/2/17.
//  Copyright © 2017 Wayne Hartman. All rights reserved.
//

import UIKit
import CoreImage

class AvatarImage: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()

        self.layer.borderColor = self.tintColor.cgColor
        self.layer.borderWidth = 5.0
        self.layer.cornerRadius = self.frame.size.height * 0.5;
    }
}
