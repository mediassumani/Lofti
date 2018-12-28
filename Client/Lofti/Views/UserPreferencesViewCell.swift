//
//  UserPreferencesViewCell.swift
//  Lofti
//
//  Created by Medi Assumani on 12/27/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import UIKit

class UserPreferencesViewCell: UICollectionViewCell {
    
    let preferenceNameLabel = CustomLabel(fontSize: 18, text: "Library", textColor: .black, textAlignment: .center, fontName: "Helvetica-Light")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutCellElements()
        //styleCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func styleCell(){
        
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.masksToBounds = true
    }
    private func layoutCellElements(){
        
        preferenceNameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5)
        preferenceNameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
        preferenceNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        preferenceNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
    }
}
