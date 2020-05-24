//
//  Network.swift
//  EPGDemo
//
//  Created by Ramon Haro Marques on 24/05/2020.
//  Copyright © 2020 Ramon Haro Marques. All rights reserved.
//

import Foundation

/// Network Error cases
enum NetworkError: Error {
    /// Informs no data is returned
    case dataCorrupted
    /// Invalid URL for request
    case invalidURL
}

/// Type of network request
enum RequestType: String{
    case get = "GET"
    case post = "POST"
}

protocol Network {
    
    /// Perform GET/POST request returning the result decoded object
    /// - Parameter urlRequest: Url request with the request config
    /// - Parameter completion: Result type handler called the request has finished
    func fetchCodable<T:Codable>(url:URL, method: RequestType, params: [String:String], completion:@escaping (Result<T,Error>)->Void)
    
}
