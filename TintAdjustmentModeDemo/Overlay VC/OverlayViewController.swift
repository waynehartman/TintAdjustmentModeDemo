//
//  OverlayViewController.swift
//  TintAdjustmentModeDemo
//
//  Created by Wayne Hartman on 1/2/17.
//  Copyright © 2017 Wayne Hartman. All rights reserved.
//

import UIKit

class OverlayViewController: UIViewController {
    @IBOutlet fileprivate var controlContainer: UIView!
    @IBOutlet fileprivate var dismissButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.transitioningDelegate = self
        self.modalPresentationStyle = .overCurrentContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismiss(_:)))
        self.view.addGestureRecognizer(tapRecognizer);
    }

    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension OverlayViewController : UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}

extension OverlayViewController : UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to), let fromVC = transitionContext.viewController(forKey: .from) else {
            transitionContext.completeTransition(false)
            return
        }

        let isPresenting = toVC == self

        if isPresenting {
            toVC.view.frame = transitionContext.containerView.bounds
            transitionContext.containerView.addSubview(toVC.view)
        }

        let dismissColor = UIColor.clear
        let presentColor = UIColor.black.withAlphaComponent(0.33333)

        let startColor = isPresenting ? dismissColor : presentColor
        let endColor = isPresenting ? presentColor : dismissColor

        let dismissTransform = CGAffineTransform.init(translationX: 0.0, y: self.controlContainer.frame.size.height)
        let presentTransform = CGAffineTransform.identity

        let startTransform = isPresenting ? dismissTransform :  presentTransform
        let endTransform = isPresenting ? presentTransform : dismissTransform

        self.controlContainer.transform = startTransform
        self.view.backgroundColor = startColor

        let duration = self.transitionDuration(using: transitionContext) + 0.2

        let presentingVC = isPresenting ? fromVC :  toVC
        let tintMode = isPresenting ? UIViewTintAdjustmentMode.dimmed : UIViewTintAdjustmentMode.normal

        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 9.0, options: [.curveLinear], animations: {
            presentingVC.view.tintAdjustmentMode = tintMode
            self.view.backgroundColor = endColor
            self.controlContainer.transform = endTransform
        }) { (didFinish: Bool) in
            transitionContext.completeTransition(didFinish)
        }
    }
}
