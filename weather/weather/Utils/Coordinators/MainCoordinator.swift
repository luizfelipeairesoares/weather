//
//  MainCoordinator.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 19/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import UIKit

class MainCoordinator: CoordinatorProtocol {
    
    func start() -> UIViewController {
        var rootViewController: UIViewController? = nil
        if let rawUserLocation = UserDefaults.standard.value(forKey: "user_location") as? [String : Any] {
            let userLocation = UserLocation(fromDict: rawUserLocation)
            rootViewController = MainViewController(with: userLocation)
        } else {
            rootViewController = LocationViewController()
        }
        let navigationController = UINavigationController(rootViewController: rootViewController!)
        navigationController.isNavigationBarHidden = true
        return navigationController
    }
    
}
