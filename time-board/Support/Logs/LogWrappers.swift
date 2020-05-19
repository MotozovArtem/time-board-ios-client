//
//  TBVerbose.swift
//  time-board
//
//  Created by Tianid on 13.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import CocoaLumberjack



enum TypeOfLog {
    case Info
    case Warning
    case Error
    case Debug
    case Verbose
}

func TBLog(messageType: CustomEventMessages?, typeOfLog: TypeOfLog, function: String = #function, line: UInt = #line, file: String = #file) {
    guard let eventMessage = messageType else { return }
    let message = showCustomErrorDesription(eventMessage: eventMessage) ?? String()
    let messageLog = getMessageLog(typeOfLog: typeOfLog, message: message, function: function, line: line, file: file)
    DDLog.log(asynchronous: true, message: messageLog)
}

func TBLog(message: String, typeOfLog: TypeOfLog, function: String = #function, line: UInt = #line, file: String = #file) {
    let messageLog = getMessageLog(typeOfLog: typeOfLog, message: message, function: function, line: line, file: file)
    DDLog.log(asynchronous: true, message: messageLog)
}

private func showCustomErrorDesription(eventMessage: CustomEventMessages) -> String? {
    switch eventMessage {
    case let .ClienSiteError(error):
        return "\(error!.localizedDescription) \(error.debugDescription)"
    case let .ConnectionError(error):
        return "\(error!.localizedDescription) \(error.debugDescription)"
    case let .JsonDecoderError(error):
        return "\(error!.localizedDescription) \(error.debugDescription)"
    case let .JsonEncoderError(error):
        return "\(error!.localizedDescription) \(error.debugDescription)"
    case let .ServerSiteError(error):
        return "\(error!.localizedDescription) \(error.debugDescription)"
    case let .NoInternetConnection(error):
        return "\(error!.localizedDescription) \(error.debugDescription)"
    case .CantCreateURL:
        return "Can`t create URL"
    case .CantCreateTask:
        return "Can`t create TASK"
    case .StartLoading:
        return "Start loading"
    case .LoadingSuccess:
        return "Loading success"
    case .EndLoading:
        return "End loading"
    }
    
}


private func getMessageLog(typeOfLog: TypeOfLog, message: String, function: String, line: UInt, file: String) -> DDLogMessage {
    switch typeOfLog {
        
    case .Info:
        return  DDLogMessage(message: message, level: .info, flag: .info, context: 0, file: file, function: function, line: line, tag: nil, options: [], timestamp: Date())
    case .Warning:
        return DDLogMessage(message: message, level: .warning, flag: .warning, context: 0, file: file, function: function, line: line, tag: nil, options: [], timestamp: Date())
    case .Error:
        return  DDLogMessage(message: message, level: .error, flag: .error, context: 0, file: file, function: function, line: line, tag: nil, options: [], timestamp: Date())
    case .Debug:
        return DDLogMessage(message: message, level: .debug, flag: .debug, context: 0, file: file, function: function, line: line, tag: nil, options: [], timestamp: Date())
    case .Verbose:
        return DDLogMessage(message: message, level: .verbose, flag: .verbose, context: 0, file: file, function: function, line: line, tag: nil, options: [], timestamp: Date())
    }
}
