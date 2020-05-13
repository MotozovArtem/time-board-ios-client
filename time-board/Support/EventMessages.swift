//
//  Errors.swift
//  time-board
//
//  Created by Tianid on 12.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

enum CustomEventMessages {
    //MARK: - Error events
    case NoInternetConnection(Error?)
    case ClienSiteError(Error?)
    case ServerSiteError(Error?)
    case ConnectionError(Error?)
    
    case JsonDecoderError(Error?)
    case JsonEncoderError(Error?)
    
    case CantCreateURL
    case CantCreateTask
    
    //MARK: - Info events
    
    case StartLoading
    case LoadingSuccess
    case EndLoading
    
    
}


