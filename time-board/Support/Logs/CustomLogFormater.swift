//
//  CustomLogError.swift
//  time-board
//
//  Created by Tianid on 13.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//
import CocoaLumberjack

class CustomLogFormatter: DDDispatchQueueLogFormatter {
    
    override init() {
        super.init()
    }
    
    override func format(message logMessage: DDLogMessage) -> String? {
        var messageType: String?
        switch logMessage.flag {
        case .debug:
            messageType = "💛"
        case .error:
            messageType = "❤️"
        case .info:
            messageType = "💙"
        case .verbose:
            messageType = "💚"
        case .warning:
            messageType = "🧡"
        default:
            messageType = String()
        }
        return "\(messageType!) >> \(logMessage.message) << | [\(logMessage.fileName):\(logMessage.line)] \(logMessage.function!)"
        
    }
}
