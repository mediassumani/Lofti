
//
//  LocationServices.swift
//  Lofti
//
//  Created by Medi Assumani on 12/5/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//
import Foundation
import CoreLocation
import MapKit

struct LocationServices{
    
    static let shared = LocationServices()
    /* Return the coordinate of a location based on its address
     @param -> address : the string formated address of a single location
     @return ->CLLocationCoordinate2D?: the coordinate obejct with latitude and longitude properties.
     */
    
    func addressToCoordinate(_ address: String, completion: @escaping(CLLocationCoordinate2D?) ->()){
        
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
    
    func centerLocationOnMap(coordinates: CLLocationCoordinate2D, annotationTitle: String, map: MKMapView, isOpen: Bool){
        
        var openStatus = ""
        if isOpen { openStatus = "Open" } else { openStatus = "Closed" }
        let regionRadius = 1000.0
        let region = MKCoordinateRegion(center: coordinates,
                                        latitudinalMeters: regionRadius,
                                        longitudinalMeters: regionRadius)
        map.setRegion(region, animated: true)
        
        let targetLocationAnnotation = MKPointAnnotation()
        targetLocationAnnotation.title = "\(annotationTitle) (\(openStatus))"
//        targetLocationAnnotation.subtitle = "Open"
        targetLocationAnnotation.coordinate = CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
        map.addAnnotation(targetLocationAnnotation)
    }
}
