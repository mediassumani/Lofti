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
        
        let baseUrl = URL(string: "https://api.yelp.com/v3/businesses/search?latitude=\(latitude)&longitude=\(longitude)&categories=libraries,communitycenters&limit=\(Constants.SEARCH_LIMIT)")
        
        var request = URLRequest(url: baseUrl!)
        request.setValue("Bearer \(Constants.YELP_API_KEY)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil{
                
                guard let unwrapedResponse = response as? HTTPURLResponse, let unwrapedData = data else {return}
                switch unwrapedResponse.statusCode{

                case 200:
                    do{
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
    
    
    
    
    static func show(id: String, completion: @escaping (Space) -> Void){
        
        let baseUrl = URL(string: "https://api.yelp.com/v3/businesses/\(id)")
        var request = URLRequest(url: baseUrl!)
        request.setValue("Bearer \(Constants.YELP_API_KEY)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error == nil{
                
                guard let dataFromApi = data, let responseFromApi = response as? HTTPURLResponse else {return}
                
                switch responseFromApi.statusCode{
                    
                case 200:
                    
                    do {
                        
                        var space = try JSONDecoder().decode(Space.self, from: dataFromApi)
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
