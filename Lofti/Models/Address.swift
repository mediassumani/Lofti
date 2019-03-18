//
//  Address.swift
//  Lofti
//
//  Created by Medi Assumani on 11/1/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import Foundation

struct Address: Decodable{
    
    let address1: String
    let city: String
    let zip_code: String
    let state: String
}
