//
//  UserPreferencesViewCell.swift
//  Lofti
//
//  Created by Medi Assumani on 12/27/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import UIKit

class UserPreferencesViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "userPreferencesCellID"
    let preferenceNameLabel = CustomLabel(fontSize: 20, text: "", textColor: .white, textAlignment: .center, fontName: "Helvetica-Bold")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutCellElements()
        //setUpGradientColor()
        //backgroundColor = .lightBlue
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    public func configureCell(preference: String, backgroundImage: UIImageView){
        
        self.preferenceNameLabel.text = preference
        self.preferenceNameLabel.numberOfLines = 2
        self.backgroundView = backgroundImage
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.shadowRadius = 1
    }
    
    private func layoutCellElements(){
        
        addSubview(preferenceNameLabel)
        
        NSLayoutConstraint.activate([
            preferenceNameLabel.widthAnchor.constraint(equalTo: widthAnchor),
            preferenceNameLabel.heightAnchor.constraint(equalTo: heightAnchor),
            preferenceNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            preferenceNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }
}
