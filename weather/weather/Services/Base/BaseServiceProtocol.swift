//
//  BaseServiceProtocol.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 17/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation
import Moya
import Mapper

protocol BaseServiceProtocol {
    
    var provider: MoyaProvider<MultiTarget> { get }
    
    init(with provider: MoyaProvider<MultiTarget>)
    
    func request<T: Mappable>(_ target: MultiTarget, completion: @escaping (Result<T, WeatherError>) -> Void)
    
}
