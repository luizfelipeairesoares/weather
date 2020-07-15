//
//  BaseService.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 17/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation
import Mapper
import Moya_ModelMapper

protocol BaseService: BaseServiceProtocol {
    
}

extension BaseService {
    
    func request<T: Mappable>(_ target: OWeatherAPI, completion: @escaping (Result<T, OWeatherAPIError>) -> Void) {
        provider.request(target) { (result) in
            switch result {
            case .success(let response):
                do {
                    let object: T = try response.map(to: T.self)
                    completion(.success(object))
                } catch {
                    completion(.failure(.jsonMapping))
                }
            case .failure(let error):
                print(error)
                completion(.failure(.unauthorized))
            }
        }
    }
    
}
