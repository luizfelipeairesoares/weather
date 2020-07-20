//
//  MainViewTests.swift
//  weatherTests
//
//  Created by Luiz Felipe Aires Soares on 19/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import XCTest
@testable import weather

class MainViewTests: XCTestCase {
    
    var mainView: MainView!
    
    override func setUpWithError() throws {
        mainView = MainView()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testProperties() throws {
        XCTAssertNotNil(mainView.alphaView)
        XCTAssertNotNil(mainView.backButton)
        XCTAssertNotNil(mainView.labelCityName)
        XCTAssertNotNil(mainView.lineView)
        XCTAssertNotNil(mainView.stackContainerView)
        XCTAssertNotNil(mainView.stackView)
        XCTAssertNotNil(mainView.currentWeatherView)
        XCTAssertNotNil(mainView.weatherInfoView)
        XCTAssertNotNil(mainView.forecastView)
        XCTAssertNotNil(mainView.locationButton)
        XCTAssertNotNil(mainView.imageView)
    }

}
