//
//  Space.swift
//  Lofti
//
//  Created by Medi Assumani on 11/1/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit

struct Space: Decodable{
    
    var name: String?
    var image_url: String?
    var _id: String?
    var is_closed: Int?
    var display_phone: String?
    var location: Address?

}
