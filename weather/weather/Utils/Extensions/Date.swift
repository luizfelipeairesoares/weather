//
//  Date.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 17/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation

extension Date {
    
    func timeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: self)
    }
    
    func weekdayString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE - dd/MM"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: self)
    }
    
}
