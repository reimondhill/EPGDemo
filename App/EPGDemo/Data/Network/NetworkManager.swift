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
        var urlRequest = URLRequest(url: url)
        
        switch method {
        case .get:
            urlRequest.httpMethod = "GET"
            urlRequest.url = urlRequest.url?.appending(params: params)
            break
        case .post:
            urlRequest.httpMethod = "POST"
            urlRequest.httpBody = params.compactMap({ "\($0.key)=\($0.value)" })
                .joined(separator: "&")
                .data(using: .utf8)
        }
        
        Logger.d(message: "Fetching at \(urlRequest.url?.absoluteString ?? "")")
        performRequest(urlRequest) { (result) in
            
            switch result{
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(T.self, from: data)
                    Logger.d(message: "\(urlRequest.url?.absoluteString ?? "") => Succcess")
                    completion(.success(response))
                }
                catch let decodeError{
                    Logger.e(message: "\(url.absoluteString) => ERROR: \(decodeError)")
                    completion(.failure(decodeError))
                }
                
            case .failure(let error):
                Logger.e(message: "\(url.absoluteString) => ERROR: \(error)")
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

}
