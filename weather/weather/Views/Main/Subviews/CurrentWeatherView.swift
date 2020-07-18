//
//  CurrentWeatherView.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 17/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import UIKit
import Kingfisher

class CurrentWeatherView: UIStackView {

    // MARK: - Private Properties
    
    private enum Constants {
        
        static let edge: CGFloat = 8.0
        
        enum TemperatureLabel {
            static let fontSize: CGFloat = 40.0
        }
        
        enum FeelsLabel {
            static let fontSize: CGFloat = 20.0
        }
        
        enum DescriptionImageView {
            static let width: CGFloat = 24.0
        }
        
        enum DescriptionLabel {
            static let fontSize: CGFloat = 20.0
        }
        
    }
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: Constants.TemperatureLabel.fontSize)
        label.textAlignment = .center
        label.shadowColor = UIColor.black.withAlphaComponent(0.24)
        label.shadowOffset = CGSize(width: 2.0, height: 2.0)
        return label
    }()
    
    private lazy var feelsLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.font = .systemFont(ofSize: Constants.FeelsLabel.fontSize)
        label.textAlignment = .center
        label.shadowColor = UIColor.black.withAlphaComponent(0.24)
        label.shadowOffset = CGSize(width: 2.0, height: 2.0)
        return label
    }()
    
    private lazy var descriptionStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var descriptionImageView: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.font = .systemFont(ofSize: Constants.FeelsLabel.fontSize)
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
        temperatureLabel.text = String(format: "%2.1fº", weather.temp.day)
        feelsLabel.text = String(format: "Feels like: %2.1fº", weather.feelsLike.day)
        guard let description = weather.weatherDescription.first else {
            descriptionStackView.isHidden = true
            return
        }
        descriptionImageView.kf.setImage(with: description.iconUrl)
        descriptionLabel.text = description.main
    }
    
    // MARK: - Private Functions
    
    private func setupSubviews() {
        addArrangedSubview(temperatureLabel)
        
        addArrangedSubview(feelsLabel)
        
        addArrangedSubview(descriptionStackView)
        setupDescriptionStackView()
    }
    
    private func setupDescriptionStackView() {
        descriptionStackView.addArrangedSubview(descriptionImageView)
        NSLayoutConstraint.activate([
            descriptionImageView.widthAnchor.constraint(equalToConstant: Constants.DescriptionImageView.width)
        ])
        descriptionStackView.addArrangedSubview(descriptionLabel)
    }

}
