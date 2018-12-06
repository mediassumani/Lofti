//
//  LocationServices.swift
//  Lofti
//
//  Created by Medi Assumani on 12/5/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import Foundation
import CoreLocation

struct GeoFence{
    
    static func addressToCoordinate(_ address: String, completion: @escaping(CLLocationCoordinate2D?) -> Void){
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            placemarks, error in
            
            if error != nil {return completion(nil)}
            
            let placemark = placemarks?.first
            let lat = placemark?.location?.coordinate.latitude
            let lon = placemark?.location?.coordinate.longitude
            guard let longitude = lon, let latitutde = lat else {return completion(nil)}
            
            return completion(CLLocationCoordinate2D(latitude: latitutde, longitude: longitude))
        }
        
    }
}
