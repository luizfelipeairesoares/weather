//
//  MainViewControllerTests.swift
//  weatherTests
//
//  Created by Luiz Felipe Aires Soares on 19/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import XCTest
import Moya
import Mapper
@testable import weather

class MainViewControllerTests: XCTestCase {
    
    var userLocation: UserLocation!
    var viewController: MainViewController!
    var weatherService: WeatherServiceMock!
    var photoService: PhotoServiceMock!
    
    override func setUpWithError() throws {
        userLocation = UserLocation(lat: 40.759211, lon: -73.984638, city: "New York")
        photoService = PhotoServiceMock(with: MoyaProvider<MultiTarget>(stubClosure: MoyaProvider.immediatelyStub))
        weatherService = WeatherServiceMock(with: MoyaProvider<MultiTarget>(stubClosure: MoyaProvider.immediatelyStub))
        viewController = MainViewController(with: userLocation, coordinator: MainCoordinator(),
                                            weatherService: weatherService, photosService: photoService)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testView() throws {
        photoService.expectedResult = .failure(.requestUnauthorized)
        weatherService.expectedResult = .failure(.requestUnauthorized)
        
        XCTAssertTrue(viewController.view is MainView)
    }
    
    func testSuccessRequest() throws {
        do {
            let mockResponse = MockResponse()
            let photoObject = try PexelsAPIResponse.from(data: mockResponse.data(json: "photos"))
            photoService.expectedResult = .success(photoObject)
            
            guard let weatherDict = try mockResponse.dictionary(json: "weather") else { fatalError() }
            
            let weatherObject = try OWeatherAPIResponse(map: Mapper(JSON: weatherDict))
            weatherService.expectedResult = .success(weatherObject)
            
            viewController.viewDidLoad()
            
            wait { [unowned self] in
                XCTAssertFalse(self.viewController.photos.isEmpty)
                XCTAssertFalse(self.viewController.weatherForecast.isEmpty)
            }
        } catch {
            throw error
        }
    }
    
    func testFailurePhotosRequest() throws {
        photoService.expectedResult = .failure(.requestUnauthorized)
        weatherService.expectedResult = .failure(.requestUnauthorized)
        
        viewController.viewDidLoad()
        
        XCTAssertTrue(self.viewController.photos.isEmpty)
        XCTAssertTrue(self.viewController.weatherForecast.isEmpty)
    }
    
    func testFailureWeatherRequest() throws {
        do {
            let mockResponse = MockResponse()
            let photoObject = try PexelsAPIResponse.from(data: mockResponse.data(json: "photos"))
            photoService.expectedResult = .success(photoObject)
            
            weatherService.expectedResult = .failure(.requestUnauthorized)
            
            viewController.viewDidLoad()
            
            XCTAssertFalse(self.viewController.photos.isEmpty)
            XCTAssertTrue(self.viewController.weatherForecast.isEmpty)
        } catch {
            throw error
        }
    }
    
    func testLocationButton() {
        photoService.expectedResult = .failure(.requestUnauthorized)
        weatherService.expectedResult = .failure(.requestUnauthorized)
        viewController.viewDidLoad()
        wait(interval: 5) {
            (self.viewController.view as! MainView).locationButton.sendActions(for: .touchUpInside)
            XCTAssertNotNil(self.viewController.presentationController)
        }
    }
    
    func testBackButton() {
        photoService.expectedResult = .failure(.requestUnauthorized)
        weatherService.expectedResult = .failure(.requestUnauthorized)
        viewController.viewDidLoad()
        let count = viewController.navigationController?.viewControllers.count ?? 1
        (viewController.view as! MainView).backButton.sendActions(for: .touchUpInside)
        if count == 1 {
            XCTAssertTrue(count == 1)
        } else {
            XCTAssertTrue(count == count-1)
        }
    }
    
//    func testCityChange() {
//        photoService.expectedResult = .failure(.requestUnauthorized)
//        weatherService.expectedResult = .failure(.requestUnauthorized)
//
//        (viewController.view as! MainView).locationButton.sendActions(for: .touchUpInside)
//
//        let alertController = viewController.presentationController as? UIAlertController
//
//        _ = expectation(for: NSPredicate(block: { (_, _) -> Bool in
//            alertController?.textFields?.first?.text = "Rio de Janeiro"
//        }), evaluatedWith: alertController, handler: nil)
//    }
    
    // MARK: - Private Functions
    
    private func wait(interval: TimeInterval = 2.0 , completion: @escaping (() -> Void)) {
        let exp = expectation(description: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            completion()
            exp.fulfill()
        }
        waitForExpectations(timeout: interval + 0.1) // add 0.1 for sure asyn after called
    }

}
