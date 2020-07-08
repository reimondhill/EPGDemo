//
//  EPGCollectionViewModel.swift
//  EPGDemo
//
//  Created by Ramon Haro Marques on 25/05/2020.
//  Copyright © 2020 Ramon Haro Marques. All rights reserved.
//

import Foundation


protocol EPGCollectionViewModelInterface {
    /// The name of the program
    var title: String { get }
}


class EPGCollectionViewModel {
    let epgProgram: EPGProgram
    
    init(epgProgram: EPGProgram) {
        self.epgProgram = epgProgram
    }
    
}


//MARK: - Public methods
//MARK: EPGCollectionViewModelInterface implementation
extension EPGCollectionViewModel: EPGCollectionViewModelInterface {
    
    var title: String { return epgProgram.title }
    
    
}


//MARK: - Private methods
