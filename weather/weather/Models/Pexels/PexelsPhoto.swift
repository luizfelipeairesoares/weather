//
//  PexelsPhoto.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 15/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation
import Mapper

struct PexelsPhoto: Mappable {
    
    let id: Int
    let width: Int
    let height: Int
    let url: String
    let src: PexelsPhotoSource
    
    private enum CodingKeys: String, CodingKey {
        case id
        case width
        case height
        case url
        case src
    }
    
    init(map: Mapper) throws {
        do {
            id              = try map.from(CodingKeys.id.rawValue)
            width           = try map.from(CodingKeys.width.rawValue)
            height          = try map.from(CodingKeys.height.rawValue)
            url             = try map.from(CodingKeys.url.rawValue)
            src             = try map.from(CodingKeys.src.rawValue)
        }
    }
    
}
