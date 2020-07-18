//
//  WeatherInfoView.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 17/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import UIKit

class WeatherInfoView: UIStackView {

    // MARK: - Private Properties
    
    private enum Constants {
        
        static let edge: CGFloat = 8.0
        
        enum SunriseLabel {
            static let fontSize: CGFloat = 16.0
        }
        
        enum SunsetLabel {
            static let fontSize: CGFloat = 16.0
        }
        
        enum HumidityLabel {
            static let fontSize: CGFloat = 16.0
        }
        
        enum WindSpeedLabel {
            static let fontSize: CGFloat = 16.0
        }
        
    }
    
    private lazy var sunriseLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.font = .systemFont(ofSize: Constants.SunriseLabel.fontSize)
        label.textAlignment = .left
        label.shadowColor = UIColor.black.withAlphaComponent(0.24)
        label.shadowOffset = CGSize(width: 2.0, height: 2.0)
        return label
    }()
    
    private lazy var sunsetLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.font = .systemFont(ofSize: Constants.SunsetLabel.fontSize)
        label.textAlignment = .left
        label.shadowColor = UIColor.black.withAlphaComponent(0.24)
        label.shadowOffset = CGSize(width: 2.0, height: 2.0)
        return label
    }()
    
    private lazy var humidityLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.font = .systemFont(ofSize: Constants.HumidityLabel.fontSize)
        label.textAlignment = .left
        label.shadowColor = UIColor.black.withAlphaComponent(0.24)
        label.shadowOffset = CGSize(width: 2.0, height: 2.0)
        return label
    }()
    
    private lazy var windSpeedLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.font = .systemFont(ofSize: Constants.WindSpeedLabel.fontSize)
        label.textAlignment = .left
        label.shadowColor = UIColor.black.withAlphaComponent(0.24)
        label.shadowOffset = CGSize(width: 2.0, height: 2.0)
        return label
    }()
    
    // MARK: - Init
    
    required init() {
        super.init(frame: .zero)
        axis = .vertical
        distribution = .fillEqually
        setupSubviews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Functions
    
    func setupView(with weather: OWeather) {
        if let sunrise = weather.sunriseDate {
            sunriseLabel.text = "Sunrise: " + sunrise.timeString()
        } else {
            sunriseLabel.isHidden = true
        }
        if let sunset = weather.sunsetDate {
            sunsetLabel.text = "Sunset: " + sunset.timeString()
        } else {
            sunsetLabel.isHidden = true
        }
        if let humidity = weather.humidity {
            humidityLabel.text = "Humidity: \(humidity)%"
        } else {
            humidityLabel.isHidden = true
        }
        if let windSpeed = weather.windSpeed {
            windSpeedLabel.text = String(format: "Wind Speed: %2.1f km/h", windSpeed * 3.6)
        } else {
            windSpeedLabel.isHidden = true
        }
    }
    
    // MARK: - Private Functions
    
    private func setupSubviews() {
        addArrangedSubview(sunriseLabel)
        addArrangedSubview(sunsetLabel)
        addArrangedSubview(humidityLabel)
        addArrangedSubview(windSpeedLabel)
    }

}
