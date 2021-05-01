//
//  RoundedCorner.swift
//  BookStore
//
//  Created by Sanjay Mali on 29/04/21.
//

import Foundation
import UIKit
extension UIView {
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            }
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue

            // Don't touch the masksToBound property if a shadow is needed in addition to the cornerRadius
            if shadow == false {
                self.layer.masksToBounds = true
            }
        }
    }


    func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
               shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
               shadowOpacity: Float = 0.4,
               shadowRadius: CGFloat = 3.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
}

extension UIView{
    func animationforSuccess(_ imageSuccess:UIImageView, _ label:[UILabel]!, _ button :UIButton, _ animation:CAMediaTimingFunctionName){
        let oldValue = imageSuccess.frame.width/2
        let newButtonWidth: CGFloat = 60
        /* Do Animations */
        CATransaction.begin() //1
        CATransaction.setAnimationDuration(2.0) //2
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name:animation)) //3

        // View animations //4
        UIView.animate(withDuration: 1.2) {
            imageSuccess.frame = CGRect(x: 0, y: 0, width: newButtonWidth, height: newButtonWidth)
            imageSuccess.center = self.center
            button.center = self.center
            for i in label{
                i.center = self.center
            }
        }
        // Layer animations
        let cornerAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.cornerRadius)) //5
        cornerAnimation.fromValue = oldValue //6
        cornerAnimation.toValue = newButtonWidth/2 //7

        imageSuccess.layer.cornerRadius = newButtonWidth/2 //8
        imageSuccess.layer.add(cornerAnimation, forKey: #keyPath(CALayer.cornerRadius)) //9
        CATransaction.commit() //10
    }
    
}
