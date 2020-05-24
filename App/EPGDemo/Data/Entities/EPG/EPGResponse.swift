//
//  EPGResponse.swift
//  EPGDemo
//
//  Created by Ramon Haro Marques on 24/05/2020.
//  Copyright © 2020 Ramon Haro Marques. All rights reserved.
//

import Foundation

struct EPGResponse: Codable {
    /// Unique identifier for the response
    let id: String
    /// Name of the response
    let title: String
    /// List of channels
    let channels: [EPGChannel]
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case channels = "sections"
    }
}
