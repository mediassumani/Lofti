//
//  SpaceServices.swift
//  Lofti
//
//  Created by Medi Assumani on 11/20/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//
import Foundation

struct SpaceServices{
    
    var apiKey: String!
//    var request: URLRequest
    //let baseUrl = URL(string: "https://api.yelp.com/v3/businesses/search")
    static let shared = SpaceServices(apiKey: Constants.YELP_API_KEY)
    
    init(apiKey: String){
        self.apiKey = Constants.YELP_API_KEY
        // 1. base link
        //let baseUrl = URL(string: "https://api.yelp.com/v3/")
//        request = URLRequest(url: baseUrl!)
//        request.setValue("Bearer \(self.apiKey!)", forHTTPHeaderField: "Authorization")
    }
    
    /* Implements The CRUD Services of a Space model
     
     Methods :
     - index : fetches all spaces nearby
     */
    
    
    /* Return an array of spaces requested from the Yelp API
     @param completion ->[Space]: The list of reminder objects to be returned after the method call
     */

    static func index(completion: @escaping(Space?) -> ()){
        
        // base url
        let baseUrl = URL(string: "https://api.yelp.com/v3/businesses/search?latitude=37.785771&longitude=-122.406165&categories=schools,libraries,collegeunive,highschools,adultedu,coffeeshops")
        
        // request
        var request = URLRequest(url: baseUrl!)
        
        // headers
        request.setValue("Bearer \(Constants.YELP_API_KEY)", forHTTPHeaderField: "Authorization")
        //request.setValue("school", forHTTPHeaderField: "term")
        //request.setValue("San Francisco", forHTTPHeaderField: "location")
        //request.setValue("Thai", forHTTPHeaderField: "term")
        
        // make call
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil{
                guard let unwrapedResponse = response as? HTTPURLResponse, let unwrapedData = data else {return}
                
                switch unwrapedResponse.statusCode{
                case 200:
                    do{
                        var space = try JSONDecoder().decode(Result.self, from: unwrapedData)
                        //completion(space)
                        print(space.businesses.last)
                        //var serialized = try JSONSerialization.jsonObject(with: unwrapedData, options: [])
                        //print(serialized)
                        

                    }catch let error{
                        print("Failed to load: \(error.localizedDescription)")
                    }
                    
                case 400:
                    print("Error Found : Bad Request. Check the URL")
                    
                default:
                    print("Error : \(error?.localizedDescription)")
                }
            }
        }
        task.resume()
        
    }
}
