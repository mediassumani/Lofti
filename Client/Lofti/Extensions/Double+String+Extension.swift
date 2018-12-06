//
//  Double+String+Extension.swift
//  TrackHub
//
//  Created by Assumani, Medi on 4/5/18.
//  Copyright © 2018 Assumani, Medi. All rights reserved.
//

import Foundation
import UIKit

extension Double{
    func convertDoubleToString() -> String{
        
        return String(self)
    }
    
    func roundToThreePlaces() -> Double {
        
        return (self * 1000) / 1000
    }
}

