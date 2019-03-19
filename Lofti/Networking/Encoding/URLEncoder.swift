//
//  URLParametersEncoder.swift
//  Lofti
//
//  Created by Medi Assumani on 2/9/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

public struct URLEncoder {
    
    /// Encode and set the parameters of a url request
    static func encodeParameters(for urlRequest: inout URLRequest, with parameters: HTTPParameters) throws {
        if parameters == nil { return }
        guard let url = urlRequest.url, let unwrappedParameters = parameters else { throw HTTPNetworkError.missingURL }
        
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !unwrappedParameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key,value) in unwrappedParameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                
                urlComponents.queryItems?.append(queryItem)
            }
            
            urlRequest.url = urlComponents.url
        }
        
    }
    
    /// Set the addition http headers of the request
    static func setHeaders(for urlRequest: inout URLRequest, with headers: HTTPHeaders) throws {
        
        if headers == nil { return }
        guard let unwrappedHeaders = headers else { throw HTTPNetworkError.headersNil }
        for (key, value) in unwrappedHeaders{
            urlRequest.setValue(value as? String, forHTTPHeaderField: key)
        }
    }
}
