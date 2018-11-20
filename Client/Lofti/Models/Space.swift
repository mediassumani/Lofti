//
//  Space.swift
//  Lofti
//
//  Created by Medi Assumani on 11/1/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit

class Space{
    
    var name: String
    var description: String
    var timeAvailable: String
    var thumbnail: UIImage
    var address: String
    var renter: String
    var capacity: Int
//    var pictures: [UIImage]?
    var hasWifi: Bool
    var price: Double
    
    init(_ name: String,
         _ description: String,
         _ timeAvailable: String,
         _ thumbnail: UIImage,
         _ address: String,
         _ renter: String,
         _ capacity: Int,
         _ hasWifi: Bool,
         _ price: Double) {

        self.name = name
        self.description = description
        self.timeAvailable = timeAvailable
        self.thumbnail = thumbnail
        self.address = address
        self.renter = renter
        self.capacity = capacity
        self.hasWifi = hasWifi
        self.price = price
    }
    
//    convenience init?(_ name: String, _ renter: User, _ price: Double) {
//        self.ini
//        self.name = name
//        self.renter = renter
//        self.price = price
//    }
}
