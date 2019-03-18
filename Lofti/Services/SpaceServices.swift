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
    static func index(longitude: Double, latitude: Double, completion: @escaping([Space]) -> Void){
        
        // Gets the user's space preferences to construct the URL with smart query string
        guard let userPreferences = UserDefaults.standard.string(forKey: "user_space_preferences") else {return}
        let baseUrl = URL(string: "https://api.yelp.com/v3/businesses/search?latitude=\(latitude)&longitude=\(longitude)&categories=\(userPreferences)")
        
        // Sets up the request to be made to the API with the proper Headers
        var request = URLRequest(url: baseUrl!)
        request.setValue("Bearer \(Constant.YELP_API_KEY)", forHTTPHeaderField: "Authorization")
        
        // Makes the API request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil{
                
                // unwrapping the data and response and checking if error has been returned
                guard let unwrapedResponse = response as? HTTPURLResponse, let unwrapedData = data else {return}
                switch unwrapedResponse.statusCode{

                case 200:
                    do{
                        // Decodes the JSON data received into a Spaces object
                        let spaces = try JSONDecoder().decode(Spaces.self, from: unwrapedData)
                        completion(spaces.businesses)

                    }catch let error{
                        
                        print("Failed to load: \(error.localizedDescription)")
                    }
                    
                default:
                    print("Error : \(error?.localizedDescription)")
                }
            }
        }
        task.resume()
    }
    
    
    /* Return a single space object requested from the Yelp API
     @param completion ->Result: The list of spaces objects to be returned after the method call
     */
    static func show(id: String, completion: @escaping (Space) -> Void){
        
        // Prepars he request to be made to the Yelp API with the proper URL and Headers
        let baseUrl = URL(string: "https://api.yelp.com/v3/businesses/\(id)")
        var request = URLRequest(url: baseUrl!)
        request.setValue("Bearer \(Constant.YELP_API_KEY)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error == nil{
                
                // unwrapping the data and response and checking if error has been returned
                guard let dataFromApi = data, let responseFromApi = response as? HTTPURLResponse else {return}
                
                switch responseFromApi.statusCode{
                    
                case 200:
                    
                    do {
                        // Decodes the JSON data received into a Space object
                        let space = try JSONDecoder().decode(Space.self, from: dataFromApi)
                        completion(space)
                        
                    } catch let error{
                        print("Error Found : \(error.localizedDescription)")
                    }
                    
    
                default:
                    print("Error found with status code ")
                }
            
            }
        }
        task.resume()
    }
}
