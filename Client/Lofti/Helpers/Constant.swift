//
//  Constant.swift
//  Lofti
//
//  Created by Medi Assumani on 12/27/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import Foundation

// This File contains constants used throughout the application

struct Constant{
    
    static let homePageCellID: String = "homepagecellidentifier"
    static let userPreferencesCellID: String = "userPreferencesCellID"
    static let onboardingViewCellIdentifier: String = "onboardingCellId"
    static let YELP_API_KEY: String = "gY2YUHqCE92WGXAVa_c9pCZfaBSXksbKJKIPOxwf_99Nrt1TVonoN2Fyk7YZffBFADtn8da2LbWQdA02G6O8QGXWb8psGP4nVaFXPz4q6QwuwLUwaZ6tA58uZ3n0W3Yx"
    static let YELP_CLIENT_ID: String = "_GWT2CXiyyxccGtUChLa6Q"
    static let SEARCH_LIMIT = 10
    static let PAUSIBLE_PREFERENCES = ["Libraries", "Coffee Shops", "Book Stores", "Shared Offices", "Parks", "Comunity Centers"]
    static let WEATHER_API_KEY: String = "d708f84ed5ebce9e7b93b60a35faf289"
    static let WEATHER_URL: URL = URL(string: "https://api.darksky.net/forecast/")!
    
    static let pages = [
        Page(imageName: "Logo_onboarding", header: "Welcome to Lofti", description: "Lofti helps you find your ideal study and working spaces nearby based on your preferences."),
        
        Page(imageName: "preferences", header: "Preferences", description: "As a first time user, pick your study/working preferences such as Libraries and Shared offices(e.g: WeWork)."),
        
        Page(imageName: "wifi_onboarding", header: "Amenities", description: "Click on a specific space to see the wifi availability, the current weather temperature, and its open/closed status."),
        
        Page(imageName: "distance", header: "Distance", description: "Easily check the distance between you and the space in the home page."),
        
        Page(imageName: "contact", header: "Take Action", description: "Contact the space customer service or get the directions there with a click of a button.")
    ]
}

