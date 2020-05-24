//
//  EPGChannel.swift
//  EPGDemo
//
//  Created by Ramon Haro Marques on 24/05/2020.
//  Copyright © 2020 Ramon Haro Marques. All rights reserved.
//

import Foundation

struct EPGChannel: Codable {
    /// Unique identifier of the channel
    let id: String
    /// Name of the program
    let title: String
    
    /// Logo url string for the channel.
    let logoURLSting: String?
    /// Logo url for the channel.
    var logoURL: URL? { return URL(string: logoURLSting ?? "")  }
    
    /// Image url string for the channel.
    let imageURLSting: String?
    /// Image url for the channel.
    var imageURL: URL? { return URL(string: imageURLSting ?? "")  }
    
    
    let programs: [EPGProgram]
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case programs = "tiles"
        case logoURLSting = "logo"
        case imageURLSting = "image"
    }
}
