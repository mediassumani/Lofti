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
}

extension String{
    func convertSringToDouble(_ stringValue: String?) -> Double?{
        guard let stringToBeDouble = stringValue else {
            return nil
        }
        return Double(stringToBeDouble)
    }
}
