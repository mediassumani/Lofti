//
//  Page.swift
//  Lofti
//
//  Created by Medi Assumani on 1/2/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

/*
 The Page Struct models each page on the onboarding screen
 Properties:
 - imageName : the file name of the image to be displayed on the page
 - header : the short header text to be displayed on the page
 - description : the description to be displayed on the page
 **/

struct Page {
    
    let imageName: String
    let headerText: String
    let description: String
    
    init(imageName: String, headerText: String, description: String) {
        
        self.imageName = imageName
        self.headerText = headerText
        self.description = description
    }
}
