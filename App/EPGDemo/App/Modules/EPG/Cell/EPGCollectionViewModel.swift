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
    var startTimeString: String? { get }
    var endTimeString: String? { get }
    var periodString: String? { get }
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
    
    var startTimeString: String? {
        return epgProgram.startDate()?.timeString(shouldShowSeconds: false, twentyFourHourFormat: true)
    }
       
    var endTimeString: String? {
        epgProgram.endDate()?.timeString(shouldShowSeconds: false, twentyFourHourFormat: true)
    }
    
    var periodString: String? {
        guard let startTimeString = startTimeString,
            let endTimeString = endTimeString else { return nil }
        
        return startTimeString + " - " + endTimeString
    }
    
}


//MARK: - Private methods
