//
//  HomePageCollectionViewCell.swift
//  Lofti
//
//  Created by Medi Assumani on 11/27/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import UIKit

class HomePageCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String = "homePageCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Layout views inside the cell
        
//        let textLabel = UILabel(frame: .zero)
//        textLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(textLabel)
        
        // Aplying constraints
        NSLayoutConstraint.activate([
            self.contentView.centerXAnchor.constraint(equalTo: textLabel.centerXAnchor),
            self.contentView.centerYAnchor.constraint(equalTo: textLabel.centerYAnchor),
            ])
        
        // Customization
        self.backgroundColor = UIColor.black
        
        //self.textLabel = textLabel
        anchorCellItems()
        
    }
    
    var textLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .white
        //label.font = UIFont.boldSystemFont(ofSize: 15)
        label.font = UIFont(name:"Helvetica", size: 20.0)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    open var spaceLabel: UILabel = {
//       
//        let label = UILabel()
//        label.textColor = .white
//        //label.font = UIFont.boldSystemFont(ofSize: 20)aa
//        label.font = UIFont(name: "Helvetica-Bold", size: 20)
//        label.textAlignment = .left
//        label.numberOfLines = 0
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//        
//    }()
//    
//    fileprivate func addViews(){
//        addSubview(spaceLabel)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//    }
//    
//    fileprivate func setUpViews(){
//        spaceLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
//    }
    
    func anchorCellItems(){
        addSubview(textLabel)
        
        textLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
