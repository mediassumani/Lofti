//
//  HomePageTableViewCell.swift
//  Lofti
//
//  Created by Medi Assumani on 11/6/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import UIKit

class HomePageTableViewCell: UITableViewCell{
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCellElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder:) has not been implemented")
    }
    
    /// Sets up the labels and image for each cell
    func setUpCellElements(){
        
    }
}
