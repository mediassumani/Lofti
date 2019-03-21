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
    let preferenceNameLabel = CustomLabel(fontSize: 18, text: "", textColor: .black, textAlignment: .center, fontName: "Helvetica-Light")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutCellElements()
        styleCell()
        backgroundColor = .white
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func styleCell(){
        
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
