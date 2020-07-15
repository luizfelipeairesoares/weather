//
//  OWeatherAPIError.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 10/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation

enum OWeatherAPIError: Error {
    
    case unauthorized
    case jsonMapping
    
    var localizedDescription: String {
        switch self {
        case .unauthorized:
            return "Unauthorized"
        case .jsonMapping:
            return "Mapping Error"
        }
    }
    
}
