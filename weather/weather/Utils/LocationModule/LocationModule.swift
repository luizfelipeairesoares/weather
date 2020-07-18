//
//  LocationModule.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 17/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

protocol LocationModuleProtocol: AnyObject, CLLocationManagerDelegate {
    
    typealias LocationCompletionBlock = ((Result<UserLocation, WeatherError>) -> Void)
    
    var manager: CLLocationManager { get }
    
    func requestPermission(_ block: LocationCompletionBlock?)
    
}

class LocationModule: NSObject, LocationModuleProtocol {
    
    // MARK: - Public Properties
    
    var manager: CLLocationManager
    
    var didChangeAuthorizationStatus: LocationCompletionBlock?
    
    // MARK: - Init
    
    required override init() {
        manager = CLLocationManager()
        super.init()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
    }
    
    // MARK: - Protocol Functions
    
    func requestPermission(_ block: LocationCompletionBlock?) {
        didChangeAuthorizationStatus = block
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            manager.startUpdatingLocation()
        case .denied, .notDetermined:
            manager.requestWhenInUseAuthorization()
        default:
            break
        }
    }
    
    // MARK: - LocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = manager.location {
            reverseGeocode(of: currentLocation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            manager.startUpdatingLocation()
        case .denied:
            didChangeAuthorizationStatus?(.failure(.requestUnauthorized))
        default:
            break
        }
    }
    
    // MARK: - Public Functions
    
    func locationOf(city: String, completion: @escaping LocationCompletionBlock) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(city) { (placemarks, error) in
            guard let marks = placemarks, !marks.isEmpty, let cityLocation = marks.first?.location else {
                let description = error?.localizedDescription ?? "Could not find city's latitude and longitude"
                completion(.failure(.geocodeError(description: description)))
                return
            }
            let userLocation = UserLocation(lat: cityLocation.coordinate.latitude, lon: cityLocation.coordinate.longitude, city: city)
            completion(.success(userLocation))
        }
    }
    
    // MARK: - Private Functions
    
    private func reverseGeocode(of location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let marks = placemarks, !marks.isEmpty else {
                let description = error?.localizedDescription ?? "Could not find placemark"
                self?.didChangeAuthorizationStatus?(.failure(.geocodeError(description: description)))
                return
            }
            let userLocation = UserLocation(lat: location.coordinate.latitude, lon: location.coordinate.longitude, city: marks.first!.locality)
            UserDefaults.standard.set(userLocation.toDict(), forKey: "user_location")
            self?.didChangeAuthorizationStatus?(.success(userLocation))
        }
    }
    
}
