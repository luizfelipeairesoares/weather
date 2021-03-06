//
//  PexelsAPI.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 15/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation
import Moya

enum PexelsAPI {
    
    case search(request: PexelsAPIRequest)
    
}

extension PexelsAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: Environment.current.photoApiBaseURL)!
    }
    
    var path: String {
        switch self {
        case .search:
            return "search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .search:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .search:
            return MockResponse().data(json: "photos")
        }
    }
    
    var task: Task {
        switch self {
        case .search(let request):
            return .requestParameters(parameters: request.dictionary ?? [:], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Authorization" : Environment.current.photoApiKey]
    }
    
}
