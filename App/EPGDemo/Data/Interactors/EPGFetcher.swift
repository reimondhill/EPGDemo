//
//  EPGFetcher.swift
//  EPGDemo
//
//  Created by Ramon Haro Marques on 24/05/2020.
//  Copyright © 2020 Ramon Haro Marques. All rights reserved.
//

import Foundation

protocol EPGFetcherInterface {
    
    /// Retrieves the EPG response for a day
    /// - Parameter daysOffset: Number of days where 0 is today, -(1,2,...) is past days and +(1,2,...) is future days
    /// - Parameter completion: Callback when the process is finished
    func getEPG(daysOffset: Int, completion:@escaping (Result<EPGServerResponse, Error>)->Void)
    
}


struct EPGFetcher: EPGFetcherInterface {
    private let network: Network
    
    init(network: Network = NetworkManager()) {
        self.network = network
    }
    
    func getEPG(daysOffset: Int, completion: @escaping (Result<EPGServerResponse, Error>) -> Void) {
        guard let url = URL(string: "https://v1-metadata.tvplayer-cdn.com/api/epg-nocache/2020-05-23T00:00:00%2B01:00") else { return }
        
        let params = ["cc":"gb",
                      "key":"2Pw1Eg0Px7Ey9Jm3Ly8Dr5Ci5Vc5Mk"]
        
        network.fetchCodable(url: url, method: .get, params: params, completion: completion)
    }
}
