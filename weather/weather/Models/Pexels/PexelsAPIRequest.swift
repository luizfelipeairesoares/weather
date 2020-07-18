//
//  PexelsAPIRequest.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 15/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation

struct PexelsAPIRequest: Encodable {
    
    let query: String
    let page: Int
    
    private enum CodingKeys: String, CodingKey {
        case query
        case page
    }
    
    var dictionary: [String : Any]? {
        return [
            "query" : query,
            "page"  : page
        ]
    }
    
}
