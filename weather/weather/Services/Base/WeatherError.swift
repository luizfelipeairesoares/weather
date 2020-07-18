//
//  WeatherError.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 10/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation

enum WeatherError: Error {
    
    case requestUnauthorized
    case jsonMapping
    case locationUnauthorized
    case geocodeError(description: String)
    
    var localizedDescription: String {
        switch self {
        case .requestUnauthorized:
            return "Request Unauthorized"
        case .jsonMapping:
            return "Mapping Error"
        case .locationUnauthorized:
            return "Location Unauthorized"
        case .geocodeError(let description):
            return "Geocode Error: \(description)"
        }
    }
    
}
