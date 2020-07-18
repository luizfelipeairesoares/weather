//
//  PexelsService.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 15/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation
import Moya

protocol PexelsServiceProtocol: BaseService {
    
    func requestPhotos(request: PexelsAPIRequest, completion: @escaping (Result<PexelsAPIResponse, WeatherError>) -> Void)
    
}

struct PexelsService: PexelsServiceProtocol {
    
    var provider: MoyaProvider<MultiTarget>
    
    init(with provider: MoyaProvider<MultiTarget> = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: NetworkLoggerPlugin.Configuration.LogOptions.verbose))])) {
        self.provider = provider
    }
    
    func requestPhotos(request: PexelsAPIRequest, completion: @escaping (Result<PexelsAPIResponse, WeatherError>) -> Void) {
        let multiTarget = MultiTarget(PexelsAPI.search(request: request))
        self.request(multiTarget) { (result: Result<PexelsAPIResponse, WeatherError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
