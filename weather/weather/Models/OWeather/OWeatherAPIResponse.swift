//
//  OWeatherAPIResponse.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 10/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation
import Mapper

struct OWeatherAPIResponse: Mappable {
    
    let lat: Double
    let lon: Double
    let timezone: String
    let timezoneOffset: Double
    let weather: OWeather
    let hourly: [OWeather]
    let daily: [OWeather]
    
    private enum CodingKeys: String, CodingKey {
        case lat
        case lon
        case timezone
        case timezoneOffset             = "timezone_offset"
        case weather                    = "current"
        case hourly
        case daily
    }
    
    init(map: Mapper) throws {
        do {
            lat                 = try map.from(CodingKeys.lat.rawValue)
            lon                 = try map.from(CodingKeys.lon.rawValue)
            timezone            = try map.from(CodingKeys.timezone.rawValue)
            timezoneOffset      = try map.from(CodingKeys.timezoneOffset.rawValue)
            weather             = try map.from(CodingKeys.weather.rawValue)
            hourly              = try map.from(CodingKeys.hourly.rawValue)
            daily               = try map.from(CodingKeys.daily.rawValue)
        } catch {
            throw error
        }
    }
    
}
