//
//  PexelsAPIResponse.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 15/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation
import Mapper

struct PexelsAPIResponse: Mappable, Decodable {
    
    let totalResult: Int
    let page: Int
    let perPage: Int
    let photos: [PexelsPhoto]
    let nextPage: String
    
    private enum CodingKeys: String, CodingKey {
        case totalResult            = "total_results"
        case page
        case perPage                = "per_page"
        case photos
        case nextPage               = "next_page"
    }
    
    init(map: Mapper) throws {
        do {
            self.totalResult            = try map.from(CodingKeys.totalResult.stringValue)
            self.page                   = try map.from(CodingKeys.page.stringValue)
            self.perPage                = try map.from(CodingKeys.perPage.stringValue)
            self.photos                 = try map.from(CodingKeys.photos.stringValue)
            self.nextPage               = try map.from(CodingKeys.nextPage.stringValue)
        } catch {
            print(error)
            throw error
        }
    }
    
    static func from(data: Data) throws -> PexelsAPIResponse {
        do {
            let object = try JSONDecoder().decode(PexelsAPIResponse.self, from: data)
            return object
        } catch {
            throw error
        }
    }
    
}
