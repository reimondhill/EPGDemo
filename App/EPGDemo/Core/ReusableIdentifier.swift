//
//  ReusableIdentifier.swift
//  EPGDemo
//
//  Created by Ramon Haro Marques on 25/05/2020.
//  Copyright © 2020 Ramon Haro Marques. All rights reserved.
//

import Foundation

protocol ReusableIdentifier {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableIdentifier{
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}
