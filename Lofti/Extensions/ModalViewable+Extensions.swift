//
//  ModalViewable+Extensions.swift
//  Lofti
//
//  Created by Medi Assumani on 3/23/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit

extension ModalViewable where Self: UIView {
    
    /**
        Presents a conformed view with animation or not. If animated is true, the UIView class slowly shows the background view
        and the dialogView on the screen for 0.33 seconds. If false, then the view pops up modally without animation
     **/
    func present(animated: Bool) {
        
        self.backgroundView.alpha = 0
        self.dialogView.center = CGPoint(x: self.center.x, y: self.frame.height + self.dialogView.frame.height/2)
        UIApplication.shared.delegate?.window??.rootViewController?.view.addSubview(self)
        
        if animated {
            UIView.animate(withDuration: 0.33, animations: {
                self.backgroundView.alpha = 0.66
            })
            
            UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 10, options: UIView.AnimationOptions(rawValue: 0), animations: {
                self.dialogView.center  = self.center
            }, completion: { (completed) in
                
            })
        }else{
            
            self.backgroundView.alpha = 0.66
            self.dialogView.center  = self.center
        }
    }
    
    /**
        Dismisses a conformed view with animation or not. If animated is true, the UIView class slowly removes the background view
        and the dialogView from the screen for 0.33 seconds. If false, then the view pops out modally without animation
     **/
    func dismiss(animated: Bool) {
        
        if animated {
            UIView.animate(withDuration: 0.33, animations: {
                self.backgroundView.alpha = 0
            }, completion: { (completed) in
                
            })
            
            UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 10, options: UIView.AnimationOptions(rawValue: 0), animations: {
                self.dialogView.center = CGPoint(x: self.center.x, y: self.frame.height + self.dialogView.frame.height/2)
            }, completion: { (completed) in
                self.removeFromSuperview()
            })
        }else{
            self.removeFromSuperview()
        }
    }
}
