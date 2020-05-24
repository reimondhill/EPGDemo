//
//  NetworkManager.swift
//  EPGDemo
//
//  Created by Ramon Haro Marques on 24/05/2020.
//  Copyright © 2020 Ramon Haro Marques. All rights reserved.
//

import Foundation


class NetworkManager: NSObject, Network {
    
    func fetchCodable<T>(url:URL, method: RequestType, params: [String: String], completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        
        print(self, #function, "Fetching at ", url.absoluteString)
        var urlRequest = URLRequest(url: url)
        
        switch method {
        case .get:
            urlRequest.httpMethod = "GET"
            urlRequest.url = urlRequest.url?.appending(queryItems: getURLQueryItems(params: params))
            break
        case .post:
            urlRequest.httpMethod = "POST"
            urlRequest.httpBody = getPostString(params: params).data(using: .utf8)
        }
        
        performRequest(urlRequest) { (result) in
            
            switch result{
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(response))
                }
                catch let decodeError{
                    completion(.failure(decodeError))
                }
                
            case .failure(let error):
                completion(.failure(error))
                
            }
            
        }
        
    }
    
}


//MARK: - Private methods
private extension NetworkManager {
    
    func performRequest(_ urlRequest: URLRequest, completion: @escaping ((Result<Data, Error>)->Void) ){
        
        guard urlRequest.url != nil else{
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        let urlSession = URLSession(configuration: sessionConfig)
        urlSession.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data,
                let response = response as? HTTPURLResponse,
                (200 ..< 300) ~= response.statusCode
                else{
                    
                    completion(.failure(NetworkError.dataCorrupted))
                    return
                    
            }
            
            completion(.success(data))
            
        }.resume()
        
    }
    
    func getURLQueryItems(params: [String:String]) -> [URLQueryItem] {
        return params
            .compactMap({ URLQueryItem(name: $0.key, value: $0.value) })
    }
    
    func getPostString(params: [String: Any]) -> String {
        return params
            .compactMap({ "\($0.key)=\($0.value)" })
            .joined(separator: "&")
    }
    
}
