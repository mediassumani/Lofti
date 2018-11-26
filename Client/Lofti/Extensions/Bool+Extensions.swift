//
//  Bool+Extensions.swift
//  Lofti
//
//  Created by Medi Assumani on 11/26/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import Foundation

extension Bool{
    
    /// Converts a boolean value into a string value
    func convertToString() -> String?{
        switch self{
            
        case true:
            return "Open"
        case false:
            return "Closed"
        default:
            return nil
        }
    }
}
