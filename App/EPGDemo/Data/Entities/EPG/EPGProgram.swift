//
//  EPGProgram.swift
//  EPGDemo
//
//  Created by Ramon Haro Marques on 24/05/2020.
//  Copyright © 2020 Ramon Haro Marques. All rights reserved.
//

import Foundation

struct EPGProgram: Codable {
    /// Unique identifier of the program
    let id: String
    /// Name of the program
    let title: String
    
    /// Start of the program in UTC
    let startDateString: String?
    /// End of the program in UTC
    let endDateString: String?
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        
        case startDateString
        case endDateString
    }
}
