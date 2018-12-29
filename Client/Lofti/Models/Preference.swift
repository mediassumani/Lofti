//
//  Preference.swift
//  Lofti
//
//  Created by Medi Assumani on 12/28/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import Foundation


struct Preference{
    
    var name: String
    var isSelected: Bool
    
    init(name: String) {
        self.name = name
        self.isSelected = false
    }
}
