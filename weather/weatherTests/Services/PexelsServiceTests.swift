//
//  PexelsServiceTests.swift
//  weatherTests
//
//  Created by Luiz Felipe Aires Soares on 19/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import XCTest
import Moya
import Mapper
@testable import weather

class PexelsServiceTests: XCTestCase {
    
    var service: PexelsService!
    
    override func setUpWithError() throws {
        service = PexelsService(with: MoyaProvider<MultiTarget>(stubClosure: MoyaProvider.delayedStub(2)))
    }
    
    override func tearDownWithError() throws {
        service = nil
        try super.tearDownWithError()
    }
    
    func testSuccess() throws {
        var success = false
        let expectation = self.expectation(description: "request")
        service.requestPhotos(request: .init(query: "New York", page: 1)) { (result) in
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
