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


struct OperatingHour: Decodable{
    
    let is_open_now: Bool?
    
    enum CodingKeys: String, CodingKey{
        case is_open_now = "is_open_now"
    }

    enum HoursKey: String, CodingKey{
        case hours = "hours"
    }

    init(from decoder: Decoder) throws{

        var values = try decoder.unkeyedContainer()
        
        var u = try values.nestedContainer(keyedBy: CodingKeys.self)
        
        
        is_open_now = false
    }
}

class Space: Decodable{
    
    let name: String
    let id: String
    let phone: String
    let image_url: String
    let location: Address
    var distance: Double?
    var hours: OperatingHour?
}


