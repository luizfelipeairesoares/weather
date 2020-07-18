//
//  OWeatherDescription.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 10/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation
import Mapper

struct OWeatherDescription: Mappable {
    
    let id: Int
    let main: String
    let desc: String
    let icon: String
    
    var iconUrl: URL? {
        return URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case main
        case desc       = "description"
        case icon
    }
    
    init(map: Mapper) throws {
        do {
            id              = try map.from(CodingKeys.id.rawValue)
            main            = try map.from(CodingKeys.main.rawValue)
            desc            = try map.from(CodingKeys.desc.rawValue)
            icon            = try map.from(CodingKeys.icon.rawValue)
        } catch {
            throw error
        }
    }
    
}
