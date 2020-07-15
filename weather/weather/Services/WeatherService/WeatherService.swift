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
    
    func requestWeather(request: OWeatherAPIRequest, completion: @escaping (Result<OWeatherAPIResponse, OWeatherAPIError>) -> Void)
    
}

struct WeatherService: WeatherServiceProtocol {
    
    var provider: MoyaProvider<OWeatherAPI>
    
    init(with provider: MoyaProvider<OWeatherAPI> = MoyaProvider<OWeatherAPI>(plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: NetworkLoggerPlugin.Configuration.LogOptions.verbose))])) {
        self.provider = provider
    }
    
    func requestWeather(request: OWeatherAPIRequest, completion: @escaping (Result<OWeatherAPIResponse, OWeatherAPIError>) -> Void) {
        self.request(.onecall(request: request)) { (result: Result<OWeatherAPIResponse, OWeatherAPIError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
