//
//  MainViewController.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 16/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import UIKit

protocol MainViewControllerProtocol: AnyObject {
    
    init(with userLocation: UserLocation, coordinator: MainCoordinatorProtocol,
         weatherService: WeatherServiceProtocol, photosService: PexelsServiceProtocol)
    
}

class MainViewController: WeatherViewController, MainViewControllerProtocol {
    
    // MARK: - Private Properties
    
    private lazy var viewMain: MainView = {
        let view = MainView()
        return view
    }()
    
    private let currentLocation: UserLocation
    private let coordinator: MainCoordinatorProtocol
    private let weatherService: WeatherServiceProtocol
    private let photosService: PexelsServiceProtocol
    
    private(set) var weatherForecast: [OWeather]
    private(set) var photos: [PexelsPhoto]
    private var photoIndex: Int
    
    private var timerPhoto: Timer?
    private var searchedCity: String?
    
    // MARK: - Init
    
    required init(with userLocation: UserLocation, coordinator: MainCoordinatorProtocol,
                  weatherService: WeatherServiceProtocol = WeatherService(), photosService: PexelsServiceProtocol = PexelsService()) {
        photos = []
        photoIndex = 0
        currentLocation = userLocation
        weatherForecast = []
        self.coordinator = coordinator
        self.weatherService = weatherService
        self.photosService = photosService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        photos = []
        photoIndex = 0
        currentLocation = UserLocation()
        weatherForecast = []
        coordinator = MainCoordinator()
        weatherService = WeatherService()
        photosService = PexelsService()
        super.init(coder: coder)
    }
    
    // MARK: - View Controller Lifecycle
    
    override func loadView() {
        super.loadView()
        view = viewMain
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navController = navigationController, navController.viewControllers.count > 1 {
            viewMain.backButton.isHidden = navController.viewControllers.first is LocationViewController ? true : false
        }
        
        requestPhotos()
        viewMain.forecastView.collectionView.dataSource = self
        viewMain.forecastView.collectionView.delegate = self
        
        viewMain.backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        viewMain.locationButton.addTarget(self, action: #selector(locationButtonTapped(_:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        startPhotoTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        timerPhoto?.invalidate()
        timerPhoto = nil
    }
    
    // MARK: - Private Functions
    
    @IBAction private func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func locationButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: "Please, type the name of the city", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter City Name"
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (action) in
            self?.searchedCity = alert.textFields?.first?.text
            self?.showCityWeather()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func requestPhotos() {
        showLoading()
        let request = PexelsAPIRequest(query: currentLocation.city ?? "", page: 1)
        photosService.requestPhotos(request: request) { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.photos.append(contentsOf: response.photos)
                self?.startPhotoTimer()
            case .failure(let error):
                print(error)
            }
            self?.requestWeather()
        }
    }
    
    private func requestWeather() {
        let request = OWeatherAPIRequest(lat: currentLocation.lat, lon: currentLocation.lon, city: currentLocation.city)
        weatherService.requestWeather(request: request) { [weak self] (result) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.viewMain.setupView(with: response.weather, cityName: self?.currentLocation.city)
                    if !response.daily.isEmpty {
                        var forecast = response.daily
                        _ = forecast.removeFirst()
                        self?.weatherForecast = forecast
                        self?.viewMain.forecastView.label7days.text = "NEXT \(forecast.count) DAYS"
                        self?.viewMain.forecastView.collectionView.reloadData()
                    }
                }
            case .failure(let error):
                self?.showAlert(with: error.localizedDescription)
            }
            self?.hideLoading()
        }
    }
    
    private func startPhotoTimer() {
        guard !photos.isEmpty else { return }
        changePhoto()
        timerPhoto = Timer.scheduledTimer(withTimeInterval: 15, repeats: true, block: { [weak self] _ in
            self?.photoIndex += 1
            self?.changePhoto()
        })
    }
    
    private func changePhoto() {
        if photoIndex == photos.count {
            photoIndex = 0
        }
        if let portrait = photos[photoIndex].src.portrait {
            viewMain.loadPhoto(photoUrl: portrait)
        }
    }
    
    private func showCityWeather() {
        guard let city = searchedCity, !city.isEmpty else {
            return
        }
        showLoading()
        LocationModule().locationOf(city: city) { [weak self] (result) in
            DispatchQueue.main.async {
                self?.hideLoading()
                switch result {
                case .success(let location):
                    guard let navigationController = self?.navigationController else { fatalError() }
                    self?.coordinator.showMainView(userLocation: location, from: navigationController)
                case .failure(let error):
                    self?.showAlert(with: error.localizedDescription)
                }
            }
        }
    }

}

// MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherForecast.count > 7 ? 7 : weatherForecast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForecastCollectionViewCell.identifier, for: indexPath) as! ForecastCollectionViewCell
        cell.configureCell(weatherForecast[indexPath.row])
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 120.0)
    }
    
}
