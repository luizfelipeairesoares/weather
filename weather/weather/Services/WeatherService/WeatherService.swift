//
//  WeatherService.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 10/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation
import Moya

protocol WeatherServiceProtocol: BaseService {
    
    func requestWeather(request: OWeatherAPIRequest, completion: @escaping (Result<OWeatherAPIResponse, WeatherError>) -> Void)
    
}

struct WeatherService: WeatherServiceProtocol {
    
    var provider: MoyaProvider<MultiTarget>
    
    init(with provider: MoyaProvider<MultiTarget> = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: NetworkLoggerPlugin.Configuration.LogOptions.verbose))])) {
        self.provider = provider
    }
    
    func requestWeather(request: OWeatherAPIRequest, completion: @escaping (Result<OWeatherAPIResponse, WeatherError>) -> Void) {
        let multiTarget = MultiTarget(OWeatherAPI.onecall(request: request))
        self.request(multiTarget) { (result: Result<OWeatherAPIResponse, WeatherError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
