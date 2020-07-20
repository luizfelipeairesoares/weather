//
//  MainCoordinator.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 19/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import UIKit

protocol MainCoordinatorProtocol: AnyObject {
    
    func startMainView(with userLocation: UserLocation) -> MainViewControllerProtocol
    func showMainView(userLocation: UserLocation, from navigationController: UINavigationController)
    
}

class MainCoordinator: MainCoordinatorProtocol {
    
    func startMainView(with userLocation: UserLocation) -> MainViewControllerProtocol {
        let mainViewController = MainViewController(with: userLocation, coordinator: self)
        return mainViewController
    }
    
    func showMainView(userLocation: UserLocation, from navigationController: UINavigationController) {
        guard let mainViewController = startMainView(with: userLocation) as? MainViewController else { fatalError() }
        navigationController.pushViewController(mainViewController, animated: true)
    }
    
}
