//
//  Space.swift
//  Lofti
//
//  Created by Medi Assumani on 11/1/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit

struct Spaces: Decodable{
    let businesses: [Space]
}

struct Space: Decodable{
    
    let name: String
    let id: String
    let phone: String
    let image_url: String
    let location: Address
}

