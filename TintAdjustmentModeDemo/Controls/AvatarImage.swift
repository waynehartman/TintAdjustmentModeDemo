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

        let newImage = self.tintAdjustmentMode == .dimmed ? self.dimmedImage : self.normalImage

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

        let bawFilterParms : [String : Any] = [ kCIInputBrightnessKey : 0.0, kCIInputContrastKey : 1.1, kCIInputSaturationKey : 0.0, ]
        let bawFilter = CIFilter(name: "CIColorControls", withInputParameters:bawFilterParms)
        let exposureFilterParms : [String : Any] = [kCIInputEVKey : 0.7]
        let exposureFilter = CIFilter(name: "CIExposureAdjust", withInputParameters: exposureFilterParms)
        let blurFilterParms : [String : Any] = [:]
        let blurFilter = CIFilter(name: "CIDiscBlur", withInputParameters: blurFilterParms)

        var inputImage = CIImage(cgImage: image.cgImage!);
        let filters = [ bawFilter, exposureFilter,  blurFilter ]

        for filter in filters {
            filter?.setValue(inputImage, forKey: kCIInputImageKey)
            guard let outputImage = filter?.outputImage else {
                return nil
            }

            inputImage = outputImage
        }

        let context = CIContext(options: nil)
        let cgImage = context.createCGImage(inputImage, from: inputImage.extent)

        guard let outputCGImage = cgImage else {
            return nil
        }

        let dimmedImage = UIImage(cgImage: outputCGImage, scale: image.scale, orientation: image.imageOrientation)

        return dimmedImage
    }
}
