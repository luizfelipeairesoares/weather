//
//  WeatherViewController.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 19/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class WeatherViewController: UIViewController, ViewControllerProtocol {
    
    // MARK: - Properties
    
    private(set) lazy var loading: NVActivityIndicatorView = {
        let activity = NVActivityIndicatorView(frame: .zero, type: .circleStrokeSpin, color: .white, padding: nil)
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(loading)
        NSLayoutConstraint.activate([
            loading.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loading.widthAnchor.constraint(equalToConstant: 64.0),
            loading.heightAnchor.constraint(equalToConstant: 64.0)
        ])
    }
    
    // MARK: - ViewControllerProtocol Functions
    
    func showLoading(color: UIColor = .white) {
        loading.color = color
        loading.startAnimating()
    }
    
    func hideLoading() {
        loading.stopAnimating()
    }
    
    func showAlert(with message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

}
