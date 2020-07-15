//
//  Encodable.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 10/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation

extension Encodable {
    
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        let serialize = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
        return serialize.flatMap { $0 as? [String: Any] }
    }
    
}
