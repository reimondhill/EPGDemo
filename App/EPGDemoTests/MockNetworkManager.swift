//
//  MockNetworkManager.swift
//  iOSArtLogicChallenge
//
//  Created by Ramon Haro Marques on 08/12/2019.
//  Copyright © 2019 Ramon Haro Marques. All rights reserved.
//

import Foundation


//class MockNetworkManager: NSObject, Network {
//    
//    func fetchCodable<T>(url: URL, method: RequestType, params: [String : Any], completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
//                
//        var localURL:URL!
//        if url.absoluteString == "https://artlogicdevelopertest.privateviews.com/api/browse/all" {
//            localURL = Bundle.main.url(forResource: "ResponseAll", withExtension: "json")
//        }
//        else if url.absoluteString.contains("https://artlogicdevelopertest.privateviews.com/api/browse/all/"){
//            localURL = Bundle.main.url(forResource: "PresentationResponse", withExtension: "json")
//        }
//        do{
//            let response = try JSONDecoder().decode(T.self, from: try Data(contentsOf: localURL))
//            completion(.success(response))
//        }
//        catch{
//            print(logClassName, "Error fetching data", error.localizedDescription)
//            completion(.failure(error))
//        }
//        
//    }
//    
//}
