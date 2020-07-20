//
//  ViewControllerProtocol.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 19/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

protocol ViewControllerProtocol {
    
    func showLoading()
    func hideLoading()
    func showAlert(with message: String)
    
}
