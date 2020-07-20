//
//  WeatherServiceMock.swift
//  weatherTests
//
//  Created by Luiz Felipe Aires Soares on 19/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import XCTest
import Moya
@testable import weather

class WeatherServiceMock: WeatherServiceProtocol {
    
    var provider: MoyaProvider<MultiTarget>
    
    var expectedResult: Result<OWeatherAPIResponse, WeatherError>!
    
    required init(with provider: MoyaProvider<MultiTarget>) {
        self.provider = provider
    }
    
    func requestWeather(request: OWeatherAPIRequest, completion: @escaping (Result<OWeatherAPIResponse, WeatherError>) -> Void) {
        completion(expectedResult)
    }
    
}
