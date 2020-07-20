//
//  OWeatherAPI.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 10/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation
import Moya

enum OWeatherAPI {
    
    case onecall(request: OWeatherAPIRequest)
    
}

extension OWeatherAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.openweathermap.org/data/2.5/")!
    }
    
    var path: String {
        switch self {
        case .onecall:
            return "onecall"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .onecall:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .onecall:
            return MockResponse().data(json: "weather")
        }
    }
    
    var task: Task {
        switch self {
        case .onecall(let request):
            return .requestParameters(parameters: request.dictionary ?? [:], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}
