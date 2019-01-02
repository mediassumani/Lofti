//
//  Constant.swift
//  Lofti
//
//  Created by Medi Assumani on 12/27/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import Foundation

struct Constant{
    
    static let homePageCellID: String = "homepagecellidentifier"
    static let userPreferencesCellID: String = "userPreferencesCellID"
    static let YELP_API_KEY: String = "gY2YUHqCE92WGXAVa_c9pCZfaBSXksbKJKIPOxwf_99Nrt1TVonoN2Fyk7YZffBFADtn8da2LbWQdA02G6O8QGXWb8psGP4nVaFXPz4q6QwuwLUwaZ6tA58uZ3n0W3Yx"
    static let YELP_CLIENT_ID: String = "_GWT2CXiyyxccGtUChLa6Q"
    static let SEARCH_LIMIT = 10
    static public var INDEX_URL_CATEGORIES_PARAM: String = "&categories="
    static let PAUSIBLE_PREFERENCES = ["Libraries", "Coffee Shops", "Book Stores", "Shared Offices", "Parks", "Comunity Centers"]
    static let WEATHER_API_KEY: String = "d708f84ed5ebce9e7b93b60a35faf289"
    static let WEATHER_URL: URL = URL(string: "https://api.darksky.net/forecast/")!
}

