//
//  Space.swift
//  Lofti
//
//  Created by Medi Assumani on 11/1/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

struct Spaces: Decodable{
    let businesses: [Space]
}


struct OperatingHour: Decodable{
    
    var is_open_now: Bool
}

class Space: Decodable{
    
    let name: String
    let id: String
    let phone: String
    let image_url: String
    let location: Address
    let distance: Double?
    var hours: [OperatingHour]?
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
}


