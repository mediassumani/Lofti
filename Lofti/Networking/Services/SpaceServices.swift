//
//  SpaceServices.swift
//  Lofti
//
//  Created by Medi Assumani on 11/20/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//
import Foundation

struct SpaceServices{

    static let shared = SpaceServices()
    private let spaceSession = URLSession(configuration: .default)
    let headers: HTTPHeaders = ["Authorization": "Bearer \(Constant.YELP_API_KEY)"]
    
    /**
     Fetches an array of spaces requested from the Yelp API
     
     - Parameters:
        - longitude: The location's longitude coordinate
        - latitude: The location's latitude coordinate
     
     - Throws:
        - `HTTPNetworkError.decodingFailed`: If the model fails to decode
        - `HTTPNetworkError.badRequest`: If the request object is built incorrecttly
     
     - Returns: A completion handler that contains the list of spaces
     **/
    func fetchAllSpaces(longitude: Double, latitude: Double, _ completion: @escaping(Result<[Space]>) -> ()){
        
        do{
            guard let userPreferences = UserDefaults.standard.string(forKey: "user_space_preferences") else { return }
            let paramters: HTTPParameters = ["latitude": latitude, "longitude": longitude,"categories": userPreferences]
            let request = try HTTPNetworkRequest.configureHTTPRequest(from: "https://api.yelp.com/v3/businesses/search?",
                                                                      with: paramters,
                                                                      includes: headers,
                                                                      contains: nil,
                                                                      and: .get)
            
            spaceSession.dataTask(with: request) { (data, res, err) in
                if let response = res as? HTTPURLResponse, let unwrappedData = data {
                    
                    let result = HTTPNetworkResponse.handleNetworkResponse(for: response)
                    switch result {
                    case .success:
                        let result = try? JSONDecoder().decode(Spaces.self, from: unwrappedData)
                        DispatchQueue.main.async {
                            completion(Result.success(result!.businesses))
                        }
                        
                    case .failure:
                        DispatchQueue.main.async {
                            completion(Result.failure(HTTPNetworkError.decodingFailed))
                        }
                    }
                }
            }.resume()
            
        } catch {
            completion(Result.failure(HTTPNetworkError.badRequest))
        }
    }
    
    
    /**
     Fetches a single space from the Yelp API
     
     - Parameters - id : The id of the space to be fetched
     
     - Throws:
     - `HTTPNetworkError.decodingFailed`: If the model fails to decode
     - `HTTPNetworkError.badRequest`: If the request object is built incorrecttly
     
     - Returns: A completion handler that contains a single space object
     **/
    func fetchSingleSpace(id: String, completion: @escaping (Result<Space>) -> ()){
        
        do{
            let request = try HTTPNetworkRequest.configureHTTPRequest(from: "https://api.yelp.com/v3/businesses/\(id)",
                                                                      with: nil,
                                                                      includes: headers,
                                                                      contains: nil,
                                                                      and: .get)
            spaceSession.dataTask(with: request) { (data, res, err) in
                if let response = res as? HTTPURLResponse, let unwrappedData = data {
                    
                    let result = HTTPNetworkResponse.handleNetworkResponse(for: response)
                    switch result {
                    case .success:
                        let result = try? JSONDecoder().decode(Space.self, from: unwrappedData)
                        DispatchQueue.main.async {
                            completion(Result.success(result!))
                        }
                        
                    case .failure:
                        DispatchQueue.main.async {
                            completion(Result.failure(HTTPNetworkError.decodingFailed))
                        }
                    }
                }
            }.resume()
        } catch {
            completion(Result.failure(HTTPNetworkError.badRequest))
        }
    }
}
