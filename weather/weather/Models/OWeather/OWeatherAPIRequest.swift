//
//  OWeatherAPIRequest.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 10/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation

struct OWeatherAPIRequest: Encodable {
    
    let lat: Double?
    let lon: Double?
    let city: String?
    let units: String
    let appid: String
    
    init(lat: Double?, lon: Double?, city: String?) {
        self.lat    = lat
        self.lon    = lon
        self.city   = city
        self.units  = "metric"
        self.appid  = Environment.current.weatherApiKey
    }
    
    private enum CodingKeys: String, CodingKey {
        case lat
        case lon
        case city       = "q"
        case units
        case appid
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let latitude = lat {
            try container.encode(latitude, forKey: .lat)
        }
        if let longitude = lon {
            try container.encode(longitude, forKey: .lon)
        }
        if let name = city {
            try container.encode(name, forKey: .city)
        }
        try container.encode(units, forKey: .units)
        try container.encode(appid, forKey: .appid)
    }
    
    var dictionary: [String : Any]? {
        var requestDict: [String : Any] = [
            CodingKeys.units.rawValue       : units,
            CodingKeys.appid.rawValue       : appid
        ]
        if let latitude = lat, let longitude = lon {
            requestDict[CodingKeys.lat.rawValue] = latitude
            requestDict[CodingKeys.lon.rawValue] = longitude
            return requestDict
        } else if let name = city {
            requestDict[CodingKeys.city.rawValue] = name
            return requestDict
        } else {
            return nil
        }
    }
    
}
