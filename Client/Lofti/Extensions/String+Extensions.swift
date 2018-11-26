//
//  String+Extensions.swift
//  Lofti
//
//  Created by Medi Assumani on 11/26/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import Foundation


extension String {
    
    /// Convert a String value to a Bool value
    func convertToBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
    
    /// Convert a String value to a Date value
    func convertToDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = formatter.date(from: self) else {return nil}
        return date
    }
}

