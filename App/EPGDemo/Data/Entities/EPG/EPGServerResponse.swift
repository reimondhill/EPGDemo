//
//  EPGServerResponse.swift
//  EPGDemo
//
//  Created by Ramon Haro Marques on 24/05/2020.
//  Copyright © 2020 Ramon Haro Marques. All rights reserved.
//

import Foundation

struct EPGServerResponse: Codable {
    /// Information about the response
    let serverInfo: ServerInfo
    /// Response from the back end
    let response: EPGResponse
    
    
    enum CodingKeys: String, CodingKey {
        case serverInfo
        case response
    }
}
