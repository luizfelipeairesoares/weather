//
//  Environment.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 19/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation

protocol EnvironmentProtocol {
    
    var weatherApiBaseURL: String { get }
    var weatherApiKey: String { get }
    var photoApiBaseURL: String { get }
    var photoApiKey: String { get }
    
}

struct Environment: EnvironmentProtocol {
    
    var weatherApiBaseURL: String
    var weatherApiKey: String
    var photoApiBaseURL: String
    var photoApiKey: String
    
    static let current = Environment()
    
    // MARK: - Init
    
    init() {
        guard let infoDict = Bundle.main.infoDictionary else { fatalError() }
        guard let weatherServerURL = infoDict["WeatherApiServer"] as? String,
            let weatherApiKey = infoDict["WeatherApiKey"] as? String,
            let photosServerURL = infoDict["PhotoApiServer"] as? String,
            let photosApiKey = infoDict["PhotoApiKey"] as? String else {
            fatalError()
        }
        self.weatherApiBaseURL = weatherServerURL
        self.weatherApiKey = weatherApiKey
        self.photoApiBaseURL = photosServerURL
        self.photoApiKey = photosApiKey
    }
    
}
