//
//  EPGViewModel.swift
//  EPGDemo
//
//  Created by Ramon Haro Marques on 25/05/2020.
//  Copyright © 2020 Ramon Haro Marques. All rights reserved.
//

import Foundation


protocol EPGViewModelInterface {
    /// Delegate returning callbacks from the ViewModel
    var delegate: EPGViewModelDelegate? { get set }
    
    /// Number of offset day from today
    var offsetDays: Int { get set }
    /// Date selected according the offset days at midnight in UTC
    var dateSelectedAtMidnight: Date { get }
    
    /// Starts the process to fetch the EPG with offsetDays provided. Upon completion it will be notified by delegate
    func fetchEPG()
    
    /// Number of sections
    /// - Returns: The number of sections
    func numberOfSections() -> Int
    
    /// Number of items for a particular section
    /// - Parameter section: Section
    /// - Returns: The number of items
    func numberOfItems(in section: Int) -> Int
    
    /// Cell Identifier for an specific indexPath
    /// - Parameter indexPath: IndexPath of the cell
    /// - Returns: The identifier of the cell
    func indefitier(at: IndexPath) -> String
    
    /// Setups a EPGCollectionViewCellInterface cell
    /// - Parameter epgCollectionViewCell:EPGCollectionViewCellInterface to setup
    /// - Parameter indexPath: IndexPath where EPGCollectionViewCellInterface is used
    func setup(epgCollectionViewCell: EPGCollectionViewCellInterface, at indexPath: IndexPath)
    
    /// Returns the time interval in minutes from and item from the current day at 00:00:00
    /// - Parameters:
    ///   - indexPath: Index for the item
    func minutesFromCurrentDayAtMidnight(at indexPath: IndexPath) -> Float
    
    /// Returns the duration for an specific item in Minutes
    /// - Parameters:
    ///   - indexPath: Index for the item
    func minutesDuration(at indexPath: IndexPath) -> Float
}

protocol EPGViewModelDelegate: class {
    func updateView()
}


class EPGViewModel {
    
    //MARK: - Properties
    private let epgFetcher: EPGFetcherInterface
    private var epgResponse: EPGResponse? {
        didSet {
            delegate?.updateView()
        }
    }
    private var channels: [EPGChannel] {
        return epgResponse?.channels ?? []
    }
    
    private weak var _delegate: EPGViewModelDelegate?
    private var _offsetDays: Int = 0
    
    
    //MARK: - Constructor
    init(epgFetcher: EPGFetcherInterface = EPGFetcher()) {
        self.epgFetcher = epgFetcher
        
    }
    
}


//MARK: - EPGViewModelInterface implementation
extension EPGViewModel: EPGViewModelInterface {

    var delegate: EPGViewModelDelegate? {
        get { return _delegate }
        set { _delegate = newValue }
    }
    
    var offsetDays: Int {
        get { return _offsetDays }
        set { _offsetDays = newValue }
    }
    
    var dateSelectedAtMidnight: Date {
        return Date().with(offsetDays: TimeInterval(offsetDays)).dateAtMidnight
    }
    
    func fetchEPG() {
        epgFetcher.getEPG(daysOffset: offsetDays) { [weak self] (result) in
            guard let sSelf = self else { return }
            
            switch result {
            case .success(let response):
                sSelf.epgResponse = response.response
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func numberOfSections() -> Int {
        return channels.count
    }
    
    func numberOfItems(in section: Int) -> Int {
        guard let channel = channels[safe: section] else {
            return 0
        }
        
        return channel.programs.count
    }
    
    func setup(epgCollectionViewCell: EPGCollectionViewCellInterface, at indexPath: IndexPath) {
        guard let program = channels[safe: indexPath.section]?.programs[safe: indexPath.row] else {
            return
        }
        
        var epgCollectionViewCell = epgCollectionViewCell
        epgCollectionViewCell.viewModel = EPGCollectionViewModel(epgProgram: program)
    }
    
    func indefitier(at: IndexPath) -> String {
        return EPGCollectionViewCell.defaultReuseIdentifier
    }
    
    func minutesFromCurrentDayAtMidnight(at indexPath: IndexPath) -> Float {
        guard let program = channels[safe: indexPath.section]?.programs[safe: indexPath.row],
            let startDate = program.startDate()
            else { return 0 }
        
        let startDateAtMidnight = startDate.dateAtMidnight
//        print(startDateAtMidnight.seconds(from: startDate)/60)
        return startDateAtMidnight.seconds(from: startDate)/60
    }
    
    func minutesDuration(at indexPath: IndexPath) -> Float {
        guard let program = channels[safe: indexPath.section]?.programs[safe: indexPath.row],
            let startDate = program.startDate(),
            let endDate = program.endDate()
            else { return 0 }
        
        return startDate.seconds(from: endDate)/60
    }
    
}
