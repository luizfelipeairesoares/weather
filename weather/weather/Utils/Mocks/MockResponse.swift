//
//  MockResponse.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 19/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation

public class MockResponse {
    
    public init() { }
    
    public func data(json: String) -> Data {
        let resource = Bundle.main.url(forResource: json, withExtension: "json")!
        do {
            let data = try Data(contentsOf: resource)
            return data
        } catch {
            return Data()
        }
    }
    
    public func dictionary(json: String) throws -> NSDictionary? {
        let resource = Bundle.main.url(forResource: json, withExtension: "json")!
        do {
            let data = try Data(contentsOf: resource)
            if let dict = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? NSDictionary {
                return dict
            } else {
                return nil
            }
        } catch {
            throw error
        }
    }
    
}
