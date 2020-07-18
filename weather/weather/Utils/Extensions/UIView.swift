//
//  UIView.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 18/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import UIKit

extension UIView {
    
    func cornerRadius(radius: CGFloat = 8.0) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
}
