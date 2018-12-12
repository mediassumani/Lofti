//
//  HomePageCollectionViewCell.swift
//  Lofti
//
//  Created by Medi Assumani on 11/27/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import UIKit

class HomePageCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    static var identifier: String = "homePageCollectionViewCell"
    open var spaceNameLabel = CustomLabel(fontSize: 20, text: "", textColor: .black, textAlignment: .center, fontName: "HelveticaNeue-Bold")
    open var spaceDistanceLabel = CustomLabel(fontSize: 15, text: "", textColor: .black, textAlignment: .center, fontName: "HelveticaNeue-Light")
    open var cellStackView = CustomStackView()
    
    
    // MARK: Initializer
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = .white
        configureCellAutoLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Class Methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    
    func configure(_ space: Space){

        spaceNameLabel.text =  space.name
        spaceDistanceLabel.text = "\(space.distance!.convertDoubleToString()) miles away" ?? "No distance found"
    }
    
    fileprivate func configureCellAutoLayout(){
        
        cellStackView = CustomStackView(subviews: [spaceNameLabel, spaceDistanceLabel],
                                        alignment: .center,
                                        axis: .vertical,
                                        distribution: .fill)
        addSubview(cellStackView)
        cellStackView.anchor(top: topAnchor,
                             left: leftAnchor,
                             bottom: bottomAnchor,
                             right: rightAnchor,
                             paddingTop: 0,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: 0,
                             width: 0,
                             height: 0,
                             enableInsets: false)
        
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.shadowRadius = 1
        spaceNameLabel.centerXAnchor.constraint(equalTo: cellStackView.centerXAnchor).isActive = true
        spaceNameLabel.centerYAnchor.constraint(equalTo: cellStackView.centerYAnchor).isActive = true
        
        spaceDistanceLabel.centerXAnchor.constraint(equalTo: cellStackView.centerXAnchor).isActive = true
        spaceDistanceLabel.centerYAnchor.constraint(equalTo: cellStackView.centerYAnchor, constant: 25).isActive = true
    }
}
