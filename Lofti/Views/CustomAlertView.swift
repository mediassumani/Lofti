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
        view.backgroundColor = .lightBlue
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 17)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    let actionButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 17)
        button.setTitle("Okay", for: .normal)
        button.backgroundColor = .lightBlue
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
        backgroundView.addGestureRecognizer(UIGestureRecognizer(target: self, action: didTapOnBackgroundView()))
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
        
    }
}

