//
//  PhotoServiceMock.swift
//  weatherTests
//
//  Created by Luiz Felipe Aires Soares on 19/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import XCTest
import Moya
@testable import weather

class PhotoServiceMock: PexelsServiceProtocol {
    
    var provider: MoyaProvider<MultiTarget>
    
    var expectedResult: Result<PexelsAPIResponse, WeatherError>!
    
    required init(with provider: MoyaProvider<MultiTarget>) {
        self.provider = provider
    }
    
    func requestPhotos(request: PexelsAPIRequest, completion: @escaping (Result<PexelsAPIResponse, WeatherError>) -> Void) {
        completion(expectedResult)
    }
    
}
