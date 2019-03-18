//
//  Weather.swift
//  Lofti
//
//  Created by Medi Assumani on 1/1/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

/*
 The Weather Struct models each weather object of each space's location
 Properties:
 - temperature : the current temperarture of a location in Fahrenheit
 - summary : the weather summary(e.g: sunny, rainy, ect...)
 **/


struct Weather: Decodable{
    
    let temperature: Double?
    let summary: String?
    
    enum CodingKeys: String, CodingKey {
        case temperature
        case summary
    }
    enum WeatherKeys: String, CodingKey{
        case currently
    }
    
    init(from decoder: Decoder) throws{
        let values = try decoder.container(keyedBy: WeatherKeys.self)
        let weatherValues = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .currently)
        temperature = try weatherValues.decode(Double.self, forKey: .temperature)
        summary = try? weatherValues.decode(String.self, forKey: .summary)
    }
}
