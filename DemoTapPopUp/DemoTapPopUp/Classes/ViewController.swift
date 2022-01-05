//
//  ViewController.swift
//  DemoTapPopUp
//
//  Created by Jayesh Tejwani on 05/01/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var bgOfIconView: UIView!
    
    @IBOutlet weak var bgImg: UIImageView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        bgOfIconView.layer.cornerRadius = 15
        bgOfIconView.layer.masksToBounds = true
        bgImg.isHidden = true
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        showDialog(.zoomInOut)
    }
    
    fileprivate func showDialog(_ animationPattern: JTAnimationPattern) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        bgImg.isHidden = false
        presentDialogViewController(detailVC, animationPattern: animationPattern)
    }
    
    override func tapJTDialogBackgroundView(_ dismissButton: UIButton) {
        bgImg.isHidden = true
        let animationPattern: JTAnimationPattern = JTAnimationPattern(rawValue: dismissButton.tag)!
        self.dismissDialogViewController(animationPattern)
    }
    
}

