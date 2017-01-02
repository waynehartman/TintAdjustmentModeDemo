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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func showOverlay(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction) in
            // DO NOTHING
        }))

        self.present(alert, animated: true, completion: nil)
    }
}

