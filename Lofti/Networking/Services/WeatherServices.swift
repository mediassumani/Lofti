//
//  WeatherServices.swift
//  Lofti
//
//  Created by Medi Assumani on 1/1/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

class WeatherServices{
    
    static let shared = WeatherServices()
    private let weatherSession = URLSession(configuration: .default)
    private var baseURL = URL(string: "https://api.darksky.net")!
    
    
    /*
     Fetches the forecast of a single location
     - Parameters:
        - longitude: The location's longitude coordinate
        - latitude: The location's latitude coordinate
     
     - Throws:
     - `HTTPNetworkError.decodingFailed`: If the model fails to decode
     - `HTTPNetworkError.badRequest`: If the request object is built incorrecttly
     
     - Returns: A completion handler that contains a weather object with its temperature and summary
     */
    func getForecastAt(longitude: Double, latitude: Double,completion: @escaping(Result<Weather>) -> ()){
        
        do{
            let fullPath = baseURL.absoluteString + "/forecast/\(Constant.DARKSKY_API_KEY)/\(latitude),\(longitude)"
            let request = try HTTPNetworkRequest.configureHTTPRequest(from: fullPath,
                                                                      with: nil,
                                                                      includes: nil,
                                                                      contains: nil,
                                                                      and: .get)
            
            weatherSession.dataTask(with: request) { (data, res, err) in
                if let response = res as? HTTPURLResponse, let unwrappedData = data {
                    
                    let result = HTTPNetworkResponse.handleNetworkResponse(for: response)
                    switch result {
                    case .success:
                        let result = try? JSONDecoder().decode(Weather.self, from: unwrappedData)
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
