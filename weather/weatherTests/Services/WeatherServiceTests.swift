//
//  WeatherServiceTests.swift
//  weatherTests
//
//  Created by Luiz Felipe Aires Soares on 19/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import XCTest
import Moya
import Mapper
@testable import weather

class WeatherServiceTests: XCTestCase {
    
    var service: WeatherService!
    
    override func setUpWithError() throws {
        service = WeatherService(with: MoyaProvider<MultiTarget>(stubClosure: MoyaProvider.delayedStub(2)))
    }
    
    override func tearDownWithError() throws {
        service = nil
        try super.tearDownWithError()
    }
    
    func testSuccess() throws {
        var success = false
        let expectation = self.expectation(description: "request")
        service.requestWeather(request: .init(lat: 40.759211, lon: -73.984638, city: "New York")) { (result) in
            switch result {
            case .success:
                success = true
            case .failure(let error):
                print(error)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssert(success)
    }
    
}
