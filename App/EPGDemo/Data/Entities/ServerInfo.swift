//
//  ServerInfo.swift
//  EPGDemo
//
//  Created by Ramon Haro Marques on 24/05/2020.
//  Copyright © 2020 Ramon Haro Marques. All rights reserved.
//

import Foundation

struct ServerInfo: Codable {
    /// Endpoint respect base url called
    let endPoint: String
    /// Time in UTC where the response was made
    let timeString: String
    /// MD5 Hash of the response
    let hash: String
    
    
    enum CodingKeys: String, CodingKey {
        case endPoint
        case timeString = "time"
        case hash
    }
}
