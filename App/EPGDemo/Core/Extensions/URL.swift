//
//  URL.swift
//  EPGDemo
//
//  Created by Ramon Haro Marques on 24/05/2020.
//  Copyright © 2020 Ramon Haro Marques. All rights reserved.
//

import Foundation

extension URL {
    
    /// Appends parameters to the URL
    /// - Parameter queryItems: Items to be appended
    /// - Returns:  new URL by adding the query items, or nil if the URL doesn't support it.
    /// - Remark: The URL must conform to RFC 3986.
    func appending(queryItems: [URLQueryItem]) -> URL? {
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            // URL is not conforming to RFC 3986 (maybe it is only conforming to RFC 1808, RFC 1738, and RFC 2732)
            return nil
        }
        
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems
        
        return urlComponents.url
    }
    
}
