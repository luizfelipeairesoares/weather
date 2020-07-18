//
//  UserLocation.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 17/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation

struct UserLocation {
    
    var lat: Double?
    var lon: Double?
    var city: String?
    
    // MARK: - Init
    
    init(lat: Double? = nil, lon: Double? = nil, city: String? = nil) {
        self.lat = lat
        self.lon = lon
        self.city = city
    }
    
    init(fromDict dict: [String : Any])  {
        lat = dict["lat"] as? Double
        lon = dict["lon"] as? Double
        city = dict["city"] as? String
    }
    
    // MARK: - Functions
    
    func toDict() -> [String : Any] {
        var dict: [String : Any] = [:]
        if let latitude = lat {
            dict["lat"] = latitude
        }
        if let longitude = lon {
            dict["lon"] = longitude
        }
        if let city = city {
            dict["city"] = city
        }
        return dict
    }
    
}
