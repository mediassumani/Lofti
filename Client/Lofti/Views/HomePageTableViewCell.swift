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
            thumbnail.image = space?.thumbnail
            spaceNameLabel.text = space?.name
            priceTextView.text = space?.price.convertDoubleToString()
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
    private let spaceNameLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// The image to display the thumbnail of the space
    private let thumbnail: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = UIImage(named: "MakeSchoolLogo")
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 60
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.shadowRadius = 1
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    /// The label that will display the renting price
    private let priceTextView: UITextView = {
        
        let textView = UITextView()
        textView.font = UIFont.boldSystemFont(ofSize: 18)
        textView.textColor = .gloomyGreen
        textView.textAlignment = .left
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    
    //- MARK: Class Methods
    
    /// Constrains and lays out the name of the space, its thumbnail, and its price and adds them to the root view
    private func setUpViews(){
        
        // Adds each subview within the root view
        addSubview(thumbnail)
        addSubview(priceTextView)
        addSubview(spaceNameLabel)
        
        // sets up the anchoring constraint for the thumbnail
        thumbnail.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 90, height: 0, enableInsets: false)
        
        // sets up the anchoring constraint for the name of the space
        spaceNameLabel.anchor(top: topAnchor, left: thumbnail.rightAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        
        // sets up the anchoring constraint for the price of the place
        priceTextView.anchor(top: spaceNameLabel.bottomAnchor, left: thumbnail.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
    }
    
}
