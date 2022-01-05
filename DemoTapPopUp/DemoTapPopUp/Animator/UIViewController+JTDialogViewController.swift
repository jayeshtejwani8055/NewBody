
//  JTDialogViewController.swift
//  DemoTapPopUp
//
//  Created by Jayesh Tejwani on 05/01/22.
//

import UIKit

let JTSourceViewTag = 997
let JTDialogViewTag = 998
let JTOverlayViewTag = 999

var kDialogViewController = 0
var kDialogBackgroundView = 1

public extension UIViewController {
    var jt_dialogViewController: UIViewController? {
        get {
            return objc_getAssociatedObject(self, &kDialogViewController) as? UIViewController
        }
        set(newValue) {
            objc_setAssociatedObject(self, &kDialogViewController, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var jt_dialogBackgroundView: JTDialogBackgroundView? {
        get {
            return objc_getAssociatedObject(self, &kDialogBackgroundView) as? JTDialogBackgroundView
        }
        set(newValue) {
            objc_setAssociatedObject(self, &kDialogBackgroundView, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func presentDialogViewController(_ dialogViewController: UIViewController, animationPattern: JTAnimationPattern = .fadeInOut, backgroundViewType: JTDialogBackgroundViewType = .solid, dismissButtonEnabled: Bool = true, completion: (() -> Swift.Void)? = nil) {
        // get the view of viewController that called the dialog
        let sourceView = self.getSourceView()
        self.jt_dialogViewController = dialogViewController
        sourceView.tag = JTSourceViewTag
        
        // dialog View
        let dialogView: UIView = jt_dialogViewController!.view
        dialogView.autoresizingMask = [.flexibleBottomMargin, .flexibleLeftMargin, .flexibleTopMargin, .flexibleRightMargin]
        dialogView.alpha = 0.0
        dialogView.tag = JTDialogViewTag
        
        if sourceView.subviews.contains(dialogView) {
            return
        }
        
        let overlayView: UIView = UIView(frame: sourceView.bounds)
        overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        overlayView.backgroundColor = .clear
        overlayView.tag = JTOverlayViewTag
        
        // background View
        self.jt_dialogBackgroundView = JTDialogBackgroundView(frame: sourceView.bounds)
        self.jt_dialogBackgroundView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.jt_dialogBackgroundView!.backgroundColor = .clear
        self.jt_dialogBackgroundView!.backgroundViewType = backgroundViewType
        self.jt_dialogBackgroundView!.alpha = 0.0
        if let _ = self.jt_dialogBackgroundView {
            overlayView.addSubview(self.jt_dialogBackgroundView!)
        }
        
        // dismiss button
        let dismissButton = UIButton(type: .custom)
        dismissButton.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        dismissButton.backgroundColor = .clear
        dismissButton.frame = sourceView.bounds
        dismissButton.tag = animationPattern == JTAnimationPattern.fadeInOut ? JTAnimationPattern.fadeInOut.rawValue : animationPattern.rawValue
        dismissButton.addTarget(self, action: #selector(UIViewController.tapJTDialogBackgroundView(_:)), for: .touchUpInside)
        dismissButton.isEnabled = dismissButtonEnabled
        
        // add view
        overlayView.addSubview(dismissButton)
        overlayView.addSubview(dialogView)
        sourceView.addSubview(overlayView)
        
        // set animation pattern and call
        JTAnimationUtils.shared.startAnimation(self, dialogView: dialogView, sourceView: sourceView, overlayView: overlayView, animationPattern: animationPattern)
        
        // called after the dialog display
        completion?()
   }
    
    // close dialog
    func dismissDialogViewController(_ animationPattern: JTAnimationPattern = .fadeInOut) {
        let sourceView = self.getSourceView()
        let dialogView = sourceView.viewWithTag(JTDialogViewTag)!
        let overlayView = sourceView.viewWithTag(JTOverlayViewTag)!
        
        // set animation pattern and call
        JTAnimationUtils.shared.endAnimation(dialogView, sourceView: sourceView, overlayView: overlayView, animationPattern: animationPattern)
        
    }
    
    // Close the dialog by tapping the background
    @objc func tapJTDialogBackgroundView(_ dismissButton: UIButton) {
        let animationPattern: JTAnimationPattern = JTAnimationPattern(rawValue: dismissButton.tag)!
        self.dismissDialogViewController(animationPattern)
    }
    
    func getSourceView() -> UIView {
        var sourceViewController = self
        guard let parent = sourceViewController.parent else { return sourceViewController.view}
        sourceViewController = parent
        
        return sourceViewController.view
    }
}
