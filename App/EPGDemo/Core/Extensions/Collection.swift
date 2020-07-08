//
//  Collection.swift
//  EPGDemo
//
//  Created by Ramon Haro Marques on 23/06/2020.
//  Copyright © 2020 Ramon Haro Marques. All rights reserved.
//

import Foundation

extension Collection {
    
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[ index] : nil
    }
    
}
