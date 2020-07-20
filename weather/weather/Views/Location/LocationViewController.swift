//
//  LocationViewController.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 16/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private lazy var mainView: LocationView = {
        let view = LocationView()
        view.buttonAsk.addTarget(self, action: #selector(buttonPermissionTapped(_:)), for: .touchUpInside)
        view.userTappedDoneInKeyboard = { [weak self] text in
            let userLocation = UserLocation(lat: nil, lon: nil, city: text)
            self?.showMainView(with: userLocation)
        }
        return view
    }()
    
    private lazy var locationManager: LocationModule = {
        let locationModule = LocationModule()
        return locationModule
    }()
    
    // MARK: - Init
    
    required init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.addObservers()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        mainView.removeObservers()
    }
    
    // MARK: - Private Functions
    
    @IBAction private func buttonPermissionTapped(_ sender: UIButton) {
        locationManager.requestPermission { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let userLocation):
                    self?.showMainView(with: userLocation)
                case .failure(let error):
                    self?.showAlert(message: error.localizedDescription)
                }
            }
        }
    }
    
    private func showMainView(with userLocation: UserLocation) {
        guard let navigationController = navigationController else { fatalError() }
        MainCoordinator().showMainView(userLocation: userLocation, from: navigationController)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Weather", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}
