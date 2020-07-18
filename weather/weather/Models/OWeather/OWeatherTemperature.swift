//
//  OWeatherTemperature.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 10/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation
import Mapper

struct OWeatherTemperature: Mappable {
    
    let day: Double
    let min: Double?
    let max: Double?
    let night: Double?
    let eve: Double?
    let morn: Double?
    
    private enum CodingKeys: String, CodingKey {
        case day
        case min
        case max
        case night
        case eve
        case morn
    }
    
    init(map: Mapper) throws {
        do {
            day         = try map.from(CodingKeys.day.rawValue)
            min         = map.optionalFrom(CodingKeys.min.rawValue)
            max         = map.optionalFrom(CodingKeys.max.rawValue)
            night       = map.optionalFrom(CodingKeys.night.rawValue)
            eve         = map.optionalFrom(CodingKeys.eve.rawValue)
            morn        = map.optionalFrom(CodingKeys.morn.rawValue)
        } catch {
            throw error
        }
    }
    
    init(day: Double) {
        self.day = day
        self.min = day
        self.max = day
        self.night = day
        self.eve = day
        self.morn = day
    }
    
    // MARK: - Static Functions
    
    static func mapOWeatherTemperature(_ object: Any?) throws -> OWeatherTemperature {
        guard let json = object as? NSDictionary else {
            if let value = object as? Double {
                return OWeatherTemperature(day: value)
            } else {
                throw MapperError.convertibleError(value: object, type: Double.self)
            }
        }
        let map = Mapper(JSON: json)
        return try OWeatherTemperature(map: map)
    }
    
}
