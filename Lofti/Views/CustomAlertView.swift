//
//  CustomAlertView.swift
//  Lofti
//
//  Created by Medi Assumani on 3/23/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit

class CustomAlertView: UIView, ModalViewable {

    // - MARK : UI Components & Properties
    
    var backgroundView = UIView()
    
    var dialogView: UIView = {
        
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        return view
    }()

    
    var separatorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkBlue
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 17)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    let actionButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 17)
        button.setTitle("Okay", for: .normal)
        button.backgroundColor = .darkBlue
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
        return button
    }()
    
    
    
    // - MARK : Initiallizers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String?, message: String?) {
        
        self.init(frame: UIScreen.main.bounds)
        backgroundView.frame = self.frame
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0.6
        backgroundView.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(didTapOnBackgroundView)))
        addSubview(backgroundView)
        
        configureMainAutoLayout(title: title, message: message)
    }
    
    // - MARK : Methods
    
    @objc func didTapOnBackgroundView() {
        dismiss(animated: true)
    }
    
    @objc func didTapActionButton() {
        dismiss(animated: true)
    }
    
    private func configureMainAutoLayout(title: String?, message: String?){
        
        titleLabel.text = title
        titleLabel.centerAnchor(centerX: nil, centerY: nil, width: 232, height: 27)
        separatorLineView.centerAnchor(centerX: nil, centerY: nil, width: 284, height: 1)
        messageLabel.text = message
        messageLabel.centerAnchor(centerX: nil, centerY: nil, width: 284, height: 64)
        
        let mainStackView = CustomStackView(subviews: [titleLabel, separatorLineView, messageLabel],
                                            alignment: .center,
                                            axis: .vertical,
                                            distribution: .equalSpacing)
        mainStackView.spacing = 10
        dialogView.addSubview(mainStackView)
        

        mainStackView.anchor(top: dialogView.topAnchor,
                             left: dialogView.leftAnchor,
                             bottom: nil,
                             right: dialogView.rightAnchor,
                             paddingTop: 14,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: 0,
                             width: 0,
                             height: 0,
                             enableInsets: false)
        
        dialogView.addSubview(actionButton)
        actionButton.anchor(centerX: dialogView.centerXAnchor,
                            centerY: nil,
                            top: nil,
                            right: nil,
                            bottom: dialogView.bottomAnchor,
                            left: nil,
                            topPadding: 0,
                            rightPadding: 0,
                            bottomPadding: 14,
                            leftPadding: 0,
                            height: 41,
                            width: 176)
        
        addSubview(dialogView)
        dialogView.anchor(
            centerX: self.centerXAnchor,
            centerY: self.centerYAnchor,
            top: nil,
            right: nil,
            bottom: nil,
            left: nil,
            topPadding: 0,
            rightPadding: 0,
            bottomPadding: 0,
            leftPadding: 0,
            height: 214,
            width: 312)

    }
}



