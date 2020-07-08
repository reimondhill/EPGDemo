//
//  Logger.swift
//  EPGDemo
//
//  Created by Ramon Haro Marques on 16/06/2020.
//  Copyright © 2020 Ramon Haro Marques. All rights reserved.
//

import Foundation

struct Logger {
    /// Type of logs available
    enum LogType: String {
        /// To log a message
        case debug
        /// To log a warning
        case warning
        /// To log an error
        case error
    }
    
    /// Logs a debug message
    /// - Parameter message: Message to log
    /// - Parameter file: File that calls the function
    /// - Parameter line: Line of code from the file where the function is call
    /// - Parameter function: Function that calls the functon
    /// - Returns: The optional message that was logged
    @discardableResult
    static func d(message: String, file: String = #file, line: Int = #line, function: String = #function) -> String{
        return log(type: .debug, message: message, file: file, line: line, function: function)
    }
    
    /// Logs a warning message
    /// - Parameter message: Message to log
    /// - Parameter file: File that calls the function
    /// - Parameter line: Line of code from the file where the function is call
    /// - Parameter function: Function that calls the functon
    /// - Returns: The optional message that was logged
    @discardableResult
    static func w(message: String, file: String = #file, line: Int = #line, function: String = #function) -> String{
        return log(type: .warning, message: message, file: file, line: line, function: function)
    }
    
    /// Logs an error message
    /// - Parameter message: Message to log
    /// - Parameter file: File that calls the function
    /// - Parameter line: Line of code from the file where the function is call
    /// - Parameter function: Function that calls the functon
    /// - Returns: The optional message that was logged
    @discardableResult
    static func e(message: String, file: String = #file, line: Int = #line, function: String = #function) -> String{
        return log(type: .error, message: message, file: file, line: line, function: function)
    }
    
    /// Logs an message
    /// - Parameter logType: Type of message to log
    /// - Parameter message: Message to log
    /// - Parameter file: File that calls the function
    /// - Parameter line: Line of code from the file where the function is call
    /// - Parameter function: Function that calls the functon
    /// - Returns: The optional message that was logged
    @discardableResult
    static func log(type logType: LogType = .debug, message: String, file: String = #file, line: Int = #line, function: String = #function) -> String{
        var logMessage = ""
        
        switch logType{
        case .debug:
            logMessage += "🟢"
        case .warning:
            logMessage += "🟡"
        case .error:
            logMessage += "🔴"
        }
        
        let fileName = file.components(separatedBy: "/").last ?? ""
        logMessage += " \(fileName) -> LINE: \(line) -> \(function) => \(message)"
        
        print(logMessage)
        return logMessage
    }

}

