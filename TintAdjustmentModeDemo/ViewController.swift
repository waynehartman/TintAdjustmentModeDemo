//
//  ViewController.swift
//  TintAdjustmentModeDemo
//
//  Created by Wayne Hartman on 1/2/17.
//  Copyright © 2017 Wayne Hartman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func showOverlay(_ sender: Any) {
        let overlay = self.storyboard!.instantiateViewController(withIdentifier: "OverlayViewController")

        self.present(overlay, animated: true, completion: nil)
    }
}

