//
//  Date.swift
//  EPGDemo
//
//  Created by Ramon Haro Marques on 25/05/2020.
//  Copyright © 2020 Ramon Haro Marques. All rights reserved.
//

import Foundation


extension Date {
    
    /// Supported date formats
    enum Format: String {
        /// Date as **yyyy-MM-dd HH:mm:ss**
        case `default` = "yyyy-MM-dd HH:mm:ss"
        /// Date as **yyyy-MM-dd'T'HH:mm:ssZZZZZ**
        case locale = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    }
    
    /// Initialises, if possible, the date from a String using a specific format
    /// - Parameters:
    ///   - string: The date as a string
    ///   - format: Format which the date is following
    init?(string: String, using format: Format) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        
        guard let date = dateFormatter.date(from: string) else {
            return nil
        }
        
        self = date
    }
    

    /// Returns a date with the difference of seconds from GMT to current time zone.
    /// - Returns: Date
    /// - Remark: if it's 11:00:00 in GMT+1 and device is in GMT+0, Returns 09:00:00
    /// ** Call ONLY once IF AND ONLY IF you have called Date.toLocalDeviceDate first **
    var toGMTDate: Date {
        let seconds = -TimeInterval(TimeZone.current.secondsFromGMT(for: self))
        
        return Date(timeInterval: seconds, since: self)
    }
    
    /// Returns a date with the difference of seconds from current time zo to GMT.
    /// - Returns: Date
    /// - Remark: if it's 10:00:00 in GMT+0 and device is in GMT+1, Returns 11:00:00
    /// ** Call ONLY once **
    var toLocalDeviceDate: Date {
        let seconds = TimeInterval(TimeZone.current.secondsFromGMT(for: self))
        
        return Date(timeInterval: seconds, since: self)
    }
    
    /// Returns the date at midnight
    /// - Remark: In GMT, If 2020/05/22 11:00 then reurned date is **2020/05/22 00:00:00**
    var dateAtMidnight: Date {
        return Calendar(identifier: .gregorian).startOfDay(for: self)
    }
    
    /// Returns same date but 24h in the future.
    /// - Remark: FROM **2020/05/22 08:00:00** TO **2020/05/23 08:00:00**
    var nextDay: Date {
        return Date(timeInterval: (24*60*60), since: self)
    }

    
    /// Niumber of second with decimal precission from another date
    /// - Parameters:
    ///   - endDate: Date to compare with
    func seconds(from endDate: Date?) -> Float {
        guard let endDate = endDate else { return 0 }
        
        return Float(endDate.timeIntervalSince1970 - self.timeIntervalSince1970)
    }
    
    
    /// From the current value of the date, returns a new date with a certain number of days offset
    /// - Parameter offsetDays: Number of days.
    /// - Remark:
    ///    - **Negative** values return past days
    ///    - **Positive** values return future days
    ///    - **0** returns the current value of the date
    func with(offsetDays: TimeInterval) -> Date{
        return Date(timeInterval: (offsetDays * 24 * 60 * 60), since: self)
    }
    
}
