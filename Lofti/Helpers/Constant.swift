//
//  Constant.swift
//  Lofti
//
//  Created by Medi Assumani on 12/27/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import Foundation

// This File contains constants used throughout the application

enum Constant{
    
    // Constants for Networking operations
    static let YELP_API_KEY = "gY2YUHqCE92WGXAVa_c9pCZfaBSXksbKJKIPOxwf_99Nrt1TVonoN2Fyk7YZffBFADtn8da2LbWQdA02G6O8QGXWb8psGP4nVaFXPz4q6QwuwLUwaZ6tA58uZ3n0W3Yx"
    static let YELP_CLIENT_ID = "_GWT2CXiyyxccGtUChLa6Q"
    static let DARKSKY_API_KEY = "d708f84ed5ebce9e7b93b60a35faf289"
    static let WEATHER_URL = URL(string: "https://api.darksky.net/forecast/")!
    
    static let SEARCH_LIMIT = 10
    static let PAUSIBLE_PREFERENCES = ["Libraries", "Coffee Shops", "Book Stores", "Shared Offices", "Parks", "Comunity Centers"]
    
    
    // Constants for UI related operations
    
    static let pages = [
    
        Page(imageName: "Logo_onboarding", headerText: "Welcome to Lofti", description: "Lofti's mission is to connect peoole and working spaces based on their preferences."),
        Page(imageName: "preferences", headerText: "Preferences", description: "As a first time user, select your study/working environment preferences such as Libraries, coffeshops, or Shared offices(e.g: WeWork)."),
        Page(imageName: "wifi_onboarding", headerText: "Amenities", description: "Click on a specific space to see available amenities such as wifi, restroom, charging stations, and whether it is open or closed at the moment."),
        Page(imageName: "distance", headerText: "Distance", description: "Working spaces are filtered in order of closest to farthest. Click on a specific space to get a map view of the area."),
        
        Page(imageName: "temperature", headerText: "Weather", description: "Easily see the current weather at the space's location before you leave your house.")
    ]
}

