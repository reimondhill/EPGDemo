//
//  EPGProgram.swift
//  EPGDemo
//
//  Created by Ramon Haro Marques on 24/05/2020.
//  Copyright © 2020 Ramon Haro Marques. All rights reserved.
//

import Foundation

struct EPGProgram {
    /// Unique identifier of the program
    let id: String
    /// Name of the program
    let title: String
    
    /// Start of the program in UTC
    let startDateString: String?
    /// End of the program in UTC
    let endDateString: String?
}


//MARK: - Public methods
extension EPGProgram {
    
    func startDate(format: Date.Format = .locale) -> Date? {
        guard let startDateString = startDateString else { return nil }
        
        return Date(string: startDateString, using: format)
    }
    
    func enDate(format: Date.Format = .locale) -> Date? {
        guard let endDateString = endDateString else { return nil }
        
        return Date(string: endDateString, using: format)
    }
    
}


//MARK: - Codable implementation
extension EPGProgram: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case startDateString = "start"
        case endDateString = "end"
    }
    
}
