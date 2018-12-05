//
//  SpaceServices.swift
//  Lofti
//
//  Created by Medi Assumani on 11/20/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//
import Foundation

struct SpaceServices{

    
    /* Return an array of spaces requested from the Yelp API
     @param completion ->Result: The list of spaces objects to be returned after the method call
     */
    static func fetchNearbySpaces(longitude: Double, latitude: Double, completion: @escaping([Space]) -> Void){
        
        // base url with parameters
        let baseUrl = URL(string: "https://api.yelp.com/v3/businesses/search?latitude=\(latitude)&longitude=\(longitude)&categories=libraries,coffee,communitycenters&limit=\(Constants.SEARCH_LIMIT)")
        
        // request
        var request = URLRequest(url: baseUrl!)
        
        // HTTP headers
        request.setValue("Bearer \(Constants.YELP_API_KEY)", forHTTPHeaderField: "Authorization")
        
        // make API call
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // check for error in the API response
            if error == nil{
                
                guard let unwrapedResponse = response as? HTTPURLResponse, let unwrapedData = data else {return}
                switch unwrapedResponse.statusCode{
                    
                    // check if the request was successfull
                case 200:
                    do{
                        
                        // Decoding the data and send as callback
                        let spaces = try JSONDecoder().decode(Spaces.self, from: unwrapedData)
                        completion(spaces.businesses)

                    }catch let error{
                        print("Failed to load: \(error.localizedDescription)")
                    }
                    
                case 400:
                    print("Error Found : Bad Request. Check the URL")
                    
                case 404:
                    print("Error Found : Page not Found. Check your URL.")
                    
                default:
                    print("Error : \(error?.localizedDescription)")
                }
            }
        }
        task.resume()
    }
}
