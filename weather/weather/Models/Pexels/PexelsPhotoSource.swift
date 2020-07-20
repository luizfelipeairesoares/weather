//
//  PexelsPhotoSource.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 15/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation
import Mapper

struct PexelsPhotoSource: Mappable, Decodable {
    
    let original: String?
    let large2x: String?
    let large: String?
    let medium: String?
    let small: String?
    let portrait: String?
    let landscape: String?
    let tiny: String?
    
    private enum CodingKeys: String, CodingKey {
        case original
        case large2x
        case large
        case medium
        case small
        case portrait
        case landscape
        case tiny
    }
    
    init(map: Mapper) throws {
        original                    = map.optionalFrom(CodingKeys.original.rawValue)
        large2x                     = map.optionalFrom(CodingKeys.large2x.rawValue)
        large                       = map.optionalFrom(CodingKeys.large.rawValue)
        medium                      = map.optionalFrom(CodingKeys.medium.rawValue)
        small                       = map.optionalFrom(CodingKeys.small.rawValue)
        portrait                    = map.optionalFrom(CodingKeys.portrait.rawValue)
        landscape                   = map.optionalFrom(CodingKeys.landscape.rawValue)
        tiny                        = map.optionalFrom(CodingKeys.tiny.rawValue)
    }
    
}
