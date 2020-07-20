//
//  LocationViewTests.swift
//  weatherTests
//
//  Created by Luiz Felipe Aires Soares on 19/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import XCTest
@testable import weather

//class SpyDelegate: NSObject, UITextFieldDelegate {
//
//    var capturedAction: Bool = false
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        capturedAction = true
//        return true
//    }
//
//}

class LocationViewTests: XCTestCase {
    
    var locationView: LocationView!
    
    override func setUpWithError() throws {
        locationView = LocationView()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testProperties() throws {
        XCTAssertNotNil(locationView.imageView)
        XCTAssertNotNil(locationView.labelAsk)
        XCTAssertNotNil(locationView.buttonAsk)
        XCTAssertNotNil(locationView.textFieldCity)
    }
    
//    func testUserTypedTextAction() {
//        var capturedAction: Bool = false
//
//        locationView.textFieldCity.text = "Rio de Janeiro"
//
//        let expectation = self.expectation(description: "action")
//
//        _ = locationView.textFieldCity.delegate?.
//
//        locationView.userTappedDoneInKeyboard = { text in
//            capturedAction = true
//            expectation.fulfill()
//        }
//
//        waitForExpectations(timeout: 3.0, handler: nil)
//        XCTAssert(capturedAction)
//    }

}
