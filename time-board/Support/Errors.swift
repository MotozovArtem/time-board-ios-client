//
//  Errors.swift
//  time-board
//
//  Created by Tianid on 12.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

enum CustomErrors {
    case NoInternetConnection(Error?)
    case ClienSiteError(Error?)
    case ServerSiteError(Error?)
    case ConnectionError(Error?)
    
    case JsonDecoderError(Error?)
    case JsonEncoderError(Error?)
    
    case CantCreateURL
    case CantCreateTask
}

func showCustomErrorDesription(error: CustomErrors) {
    switch error {
    case let .ClienSiteError(error):
        print(error!)
    case let .ConnectionError(error):
        print(error!)
    case let .JsonDecoderError(error):
        print(error!)
    case let .JsonEncoderError(error):
        print(error!)
    case let .ServerSiteError(error):
        print(error!)
    case let .NoInternetConnection(error):
        print(error!)
    case .CantCreateURL:
        print("Can`t Create URL")
        
    case .CantCreateTask:
        print("Can`t create Task")
    }
    
    
}
