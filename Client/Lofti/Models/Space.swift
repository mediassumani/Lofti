////
////  Space.swift
////  Lofti
////
////  Created by Medi Assumani on 11/1/18.
////  Copyright © 2018 Medi Assumani. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//enum SpaceKeys: String, CodingKey{
//    case total = "total"
//}
//
//struct Space: Decodable{
//
////    let name: String?
////    let image_url: String?
////    let id: String?
////    let is_closed: Int?
////    let phone: String?
//    //var location: Address?
//    let total: Int
//
//    enum SpaceKeys: String, CodingKey{
//        case total = "total"
//        case businesses = "businesses"
//    }
//
//    init(total: Int) {
//        self.total = total
//    }
//
//    init(from decoder: Decoder) throws{
//
//        let container = try decoder.container(keyedBy: SpaceKeys.self)
//        let total: Int = try container.decode(Int.self, forKey: .total)
//
//        self.init(total: total)
//    }
//}

//
//  Space.swift
//  Lofti
//
//  Created by Medi Assumani on 11/1/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit

struct Space: Decodable{

    let name: String?
    //    let image_url: String?
    //    let id: String?
    //    let is_closed: Int?
    //    let phone: String?
    //    var location: Address?


    enum SpaceKeys: String, CodingKey{
        case name = "name"
    }

    enum OuterContainer: String, CodingKey{
        case businesses = "businesses"
    }

    init(name: String) {
        self.name = name
    }

    init(from decoder: Decoder) throws{

        let outerContaainer = try decoder.container(keyedBy: OuterContainer.self)
        var nestedOuterContainers = try outerContaainer.nestedUnkeyedContainer(forKey: .businesses)
        var businessContainer = try nestedOuterContainers.nestedContainer(keyedBy: SpaceKeys.self)
        let name = try businessContainer.decode(String.self, forKey: .name)
        self.init(name: name)
    }
}

