//
//  OWeatherAPIResponse.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 10/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation

struct OWeatherAPIResponse: Decodable {
    
    let weatherDescription: [OWeatherDescription]
    let weather: OWeather
    let wind: OWind
    let rain: OWRain
    let snow: OWSnow
    
}
