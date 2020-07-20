//
//  BaseServiceMock.swift
//  weatherTests
//
//  Created by Luiz Felipe Aires Soares on 19/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation
import Moya
import Mapper
import Moya_ModelMapper
@testable import weather

protocol BaseServiceMock: BaseServiceProtocol {
    
}

extension BaseServiceMock {
    
    func request<T: Mappable>(_ target: MultiTarget, completion: @escaping (Result<T, WeatherError>) -> Void) {
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
                completion(.failure(.requestUnauthorized))
            }
        }
    }
    
}
