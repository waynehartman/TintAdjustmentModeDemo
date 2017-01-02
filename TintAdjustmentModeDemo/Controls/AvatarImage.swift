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
    private var normalImage: UIImage?
    private var dimmedImage: UIImage?

    override func awakeFromNib() {
        super.awakeFromNib()

        self.layer.borderColor = self.tintColor.cgColor
        self.layer.borderWidth = 5.0
        self.layer.cornerRadius = self.frame.size.height * 0.5;

        self.normalImage = self.image
        self.dimmedImage = self.createDimmedImage(normalImage: self.image)
    }
    
    override func tintColorDidChange() {
        super.tintColorDidChange()

        self.layer.borderColor = self.tintColor.cgColor;

        var newImage: UIImage? = nil

        if (self.tintAdjustmentMode == .dimmed) {
            newImage = self.dimmedImage
        } else {
            newImage = self.normalImage
        }

        let transition = CATransition()
        transition.duration = CATransaction.animationDuration()
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade

        self.image = newImage

        self.layer.add(transition, forKey: nil)
    }

    private func createDimmedImage(normalImage: UIImage?) -> UIImage? {
        guard let image = normalImage else {
            return nil
        }

        let beginImage = CIImage(cgImage: image.cgImage!)
        let bawFilterParms : [String : Any] = [kCIInputImageKey : beginImage,
                                               kCIInputBrightnessKey : 0.0,
                                               kCIInputContrastKey : 1.1,
                                               kCIInputSaturationKey : 0.0,
                                               ]
        let bawFilter = CIFilter(name: "CIColorControls", withInputParameters:bawFilterParms)

        guard let bawOutputImage = bawFilter?.outputImage else {
            return nil
        }

        let exposureFilterParms : [String : Any] = [kCIInputImageKey : bawOutputImage, kCIInputEVKey : 0.7]
        let exposureFilter = CIFilter(name: "CIExposureAdjust", withInputParameters: exposureFilterParms)
        
        guard let exposureOutputImage = exposureFilter?.outputImage else {
            return nil
        }

        let context = CIContext(options: nil)
        let cgImage = context.createCGImage(exposureOutputImage, from: exposureOutputImage.extent)
        
        guard let outputCGImage = cgImage else {
            return nil
        }

        let dimmedImage = UIImage(cgImage: outputCGImage, scale: image.scale, orientation: image.imageOrientation)

        return dimmedImage
    }
}
