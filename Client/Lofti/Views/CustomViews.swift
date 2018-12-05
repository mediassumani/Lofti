//
//  CustomViews.swift
//  Lofti
//
//  Created by Medi Assumani on 12/5/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit

class CustomLabel: UILabel{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(fontSize: CGFloat, text: String, textColor: UIColor) {
        
        self.init()
        self.text = text
        self.font = UIFont.boldSystemFont(ofSize: fontSize)
        self.textColor = textColor
        self.font = UIFont(name: "HelveticaNeue-Light", size: fontSize)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomTextField: UITextField{
    
    override init(frame: CGRect) {
    
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(placeHolder: String, border: CGFloat, cornerRadius: CGFloat, borderColor: UIColor, textColor: UIColor, alignment: NSTextAlignment, borderStyle: BorderStyle){
        
        self.init()
        
        backgroundColor = .clear
        attributedPlaceholder = NSAttributedString(string: placeHolder ,attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        self.borderStyle = borderStyle
        
        if borderStyle != .none{
            layer.borderWidth = border
            layer.borderColor = borderColor.cgColor
            layer.cornerRadius = cornerRadius
        }
        self.textColor = textColor
        textAlignment = alignment
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if borderStyle == .none{
            
            let buttomRect = CGRect(x: rect.origin.x, y: rect.maxY - 2, width: rect.width, height: 1)
            
            UIColor.gray.set()
            UIRectFill(buttomRect)
        }
    }
}



class CustomStackView: UIStackView{
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    convenience init (subviews: [UIView], alignment: UIStackView.Alignment, axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution){
        
        self.init(arrangedSubviews: subviews)
        self.alignment = alignment
        self.axis = axis
        self.distribution = distribution
        translatesAutoresizingMaskIntoConstraints = false
    }
}

class CustomButton: UIButton{
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    convenience init(title: String, fontSize: CGFloat, titleColor: UIColor,target: Any?, action: Selector, event: UIControl.Event){
        
        self.init()
        
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
        self.setTitleColor(titleColor, for: .normal)
        self.addTarget(target, action: action, for: event)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isEnabled = true
        self.backgroundColor = UIColor.white
        
    }
    var shadowLayer: CAShapeLayer!
    
    var newLayerColor: UIColor = UIColor.white{
        didSet{
            if shadowLayer != nil{
                shadowLayer.fillColor = newLayerColor.cgColor
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 5).cgPath
            shadowLayer.fillColor = newLayerColor.cgColor
            
            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            shadowLayer.shadowOpacity = 0.5
            shadowLayer.shadowRadius = 2
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
}
