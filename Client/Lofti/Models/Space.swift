//
//  Space.swift
//  Lofti
//
//  Created by Medi Assumani on 11/1/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit

struct Space{
    
    var name: String
    var description: String
    var timeAvailable: String
    var address: Address
    var renter: User
    var capacity: Int
    var images: [UIImage]
    var hasWifi: Bool
}
