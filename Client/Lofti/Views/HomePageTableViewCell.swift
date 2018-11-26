//
//  HomePageTableViewCell.swift
//  Lofti
//
//  Created by Medi Assumani on 11/6/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//
/*
 This custom class contains the functionalities and AutoLayout of the home table view cells
 */


import UIKit

class HomePageTableViewCell: UITableViewCell{
    
    var space: Space?{
        didSet{
//            thumbnail.image = space?.thumbnail
//            spaceNameLabel.text = space?.name
//            priceTextView.text = space?.price.convertDoubleToString()
        }
    }
    
    //- MARK:  Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder:) has not been implemented")
    }
    
    
    //-MARK: Cell Elements
    
    
    /// The label to dispaly name of the space
    let spaceNameLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    
    //- MARK: Class Methods
    
    /// Constrains and lays out the name of the space, its thumbnail, and its price and adds them to the root view
    private func setUpViews(){
        
        // Adds each subview within the root view
        addSubview(spaceNameLabel)
        
        
        // sets up the anchoring constraint for the name of the space
        spaceNameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    }
    
}
