//
//  OWeather.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 10/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation
import Mapper

struct OWeather: Mappable {
    
    let sunrise: Float?
    let sunset: Float?
    var temp: OWeatherTemperature
    var feelsLike: OWeatherTemperature
    let pressure: Int?
    let humidity: Int?
    let uvi: Double?
    let clouds: Int?
    let windSpeed: Double?
    let windDeg: Double?
    let weatherDescription: [OWeatherDescription]
    
    private enum CodingKeys: String, CodingKey {
        case sunrise
        case sunset
        case temp
        case feelsLike              = "feels_like"
        case pressure
        case humidity
        case uvi
        case clouds
        case windSpeed              = "wind_speed"
        case windDeg                = "wind_deg"
        case weatherDescription     = "weather"
    }
    
    init(map: Mapper) throws {
        do {
            sunrise             = map.optionalFrom(CodingKeys.sunrise.rawValue)
            sunset              = map.optionalFrom(CodingKeys.sunset.rawValue)
            temp                = try map.from(CodingKeys.temp.rawValue, transformation: OWeatherTemperature.mapOWeatherTemperature(_:))
            feelsLike           = try map.from(CodingKeys.feelsLike.rawValue, transformation: OWeatherTemperature.mapOWeatherTemperature(_:))
            pressure            = map.optionalFrom(CodingKeys.pressure.rawValue)
            humidity            = map.optionalFrom(CodingKeys.humidity.rawValue)
            uvi                 = map.optionalFrom(CodingKeys.uvi.rawValue)
            clouds              = map.optionalFrom(CodingKeys.clouds.rawValue)
            windSpeed           = map.optionalFrom(CodingKeys.windSpeed.rawValue)
            windDeg             = map.optionalFrom(CodingKeys.windDeg.rawValue)
            weatherDescription  = try map.from(CodingKeys.weatherDescription.rawValue)
        } catch {
            throw error
        }
    }
    
}
