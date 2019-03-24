//
//  Constant.swift
//  Lofti
//
//  Created by Medi Assumani on 12/27/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit
import StatusAlert

// This File contains constants used throughout the application

enum Constant{
    
    // Constants for Networking operations
    static let YELP_API_KEY = "ZoxWcIoPV60yQaXvd-Jm-0XeZ6CaFZeop9FiVTjbKITho0INPFrUX6zGZ2b-uwuuPfsMH6ot2Cp_L8u4uZo9UKLbwMRth3UHKBNJrqoF9tMsONSwByJJdXyVAxOYXHYx"
    static let YELP_API_KEY_V1 =  "gY2YUHqCE92WGXAVa_c9pCZfaBSXksbKJKIPOxwf_99Nrt1TVonoN2Fyk7YZffBFADtn8da2LbWQdA02G6O8QGXWb8psGP4nVaFXPz4q6QwuwLUwaZ6tA58uZ3n0W3Yx"
    static let YELP_CLIENT_ID = "uThox4tbdfG2i_jIdcB6Rw"
    static let YELP_CLIENT_ID_V1 = "_GWT2CXiyyxccGtUChLa6Q"
    static let DARKSKY_API_KEY = "d708f84ed5ebce9e7b93b60a35faf289"
    static let WEATHER_URL = URL(string: "https://api.darksky.net/forecast/")!
    static let SEARCH_LIMIT = 10
    static var PAUSIBLE_PREFERENCES = ["Libraries", "Coffee Shops", "Book Stores", "Shared Offices", "Parks", "Comunity Centers", "Hotel Lobbies", "Museums", "Bars", "Sports Clubs"]
    
    static let PREFERENCE_CELL_IMAGES = [
        UIImageView(image: UIImage(named: "library")),
        UIImageView(image: UIImage(named: "coffee")),
        UIImageView(image: UIImage(named: "book_store")),
        UIImageView(image: UIImage(named: "shared_office")),
        UIImageView(image: UIImage(named: "park")),
        UIImageView(image: UIImage(named: "community_center")),
        UIImageView(image: UIImage(named: "hotel_lobby")),
        UIImageView(image: UIImage(named: "museum")),
        UIImageView(image: UIImage(named: "bar")),
        UIImageView(image: UIImage(named: "sport_club"))
    ]
    
    
    static func createStatusAlert(title: String, message: String, choice: Selection){
        
        let statusAlert = StatusAlert()
        
        switch choice {
        case .selected:
            
            statusAlert.image = UIImage(named: "selected")
            statusAlert.title = title
            statusAlert.message = message
            statusAlert.canBePickedOrDismissed = true
            
            
        case .deselected:
        
            statusAlert.image = UIImage(named: "deselect")
            statusAlert.title = title
            statusAlert.message = message
            statusAlert.canBePickedOrDismissed = true
        }
        
        statusAlert.showInKeyWindow()
    }
}

