//
//  MainView.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 16/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import UIKit
import Kingfisher

protocol MainViewProtocol {
    
}

class MainView: UIView {
    
    // MARK: - Private Properties
    
    private enum Constants {
        
        static let edge: CGFloat = 8.0
        
        enum BackButton {
            static let width: CGFloat = 40.0
            static let height: CGFloat = 40.0
        }
        
        enum LabelCityName {
            static let fontSize: CGFloat = 20.0
            static let height: CGFloat = 24.0
        }
        
        enum LineView {
            static let height: CGFloat = 1.0
        }
        
        enum CurrentWeatherStackView {
            static let height: CGFloat = 200.0
        }
        
        enum LocationButton {
            static let height: CGFloat = 44.0
            static let fontSize: CGFloat = 16.0
        }
        
    }
    
    private lazy var alphaView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.32)
        return view
    }()
    
    private(set) lazy var backButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "img_arrowwhiteleft"), for: .normal)
        button.setTitle(nil, for: .normal)
        button.isHidden = true
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    private(set) lazy var labelCityName: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: Constants.LabelCityName.fontSize)
        label.textColor = .white
        label.shadowColor = UIColor.black.withAlphaComponent(0.25)
        label.shadowOffset = CGSize(width: 2.0, height: 2.0)
        return label
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        view.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        return view
    }()
    
    private lazy var stackContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white.withAlphaComponent(0.16)
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16.0
        return stackView
    }()
    
    private lazy var currentWeatherView: CurrentWeatherView = {
        let view = CurrentWeatherView()
        return view
    }()
    
    private lazy var weatherInfoView: WeatherInfoView = {
        let view = WeatherInfoView()
        return view
    }()
    
    private(set) lazy var forecastView: WeatherForecastView = {
        let view = WeatherForecastView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var locationButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Change Location", for: .normal)
        button.titleLabel?.textColor = UIColor.white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.LocationButton.fontSize)
        button.backgroundColor = UIColor.lightGray.withAlphaComponent(0.9)
        return button
    }()

    // MARK: - Public Properties
    
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "img_day")
        return imageView
    }()
    
    // MARK: - Init
    
    required init() {
        super.init(frame: .zero)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Functions
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        stackContainerView.cornerRadius()
        locationButton.cornerRadius()
    }
    
    // MARK: - Public Functions
    
    public func loadPhoto(photoUrl: String) {
        let placeholder = imageView.image
        imageView.kf.setImage(with: URL(string: photoUrl), placeholder: placeholder, options: [.transition(.fade(1.0))])
    }
    
    public func setupView(with weather: OWeather, cityName: String?) {
        labelCityName.text = cityName?.uppercased() ?? "CURRENT WEATHER"
        currentWeatherView.setupView(with: weather)
        weatherInfoView.setupView(with: weather)
    }
    
    // MARK: - Private Functions
    
    private func setupSubviews() {
        addSubview(imageView)
        setupImageViewConstraints()
        
        addSubview(alphaView)
        setupAlphaViewConstraints()
        
        alphaView.addSubview(backButton)
        setupBackButtonConstraints()
        
        alphaView.addSubview(labelCityName)
        setupLabelCityNameConstraints()
        
        alphaView.addSubview(lineView)
        setupLineViewConstraints()
        
        alphaView.addSubview(stackContainerView)
        setupStackContainerViewConstraints()
        
        stackContainerView.addSubview(stackView)
        setupStackViewConstraints()
        setupStackView()
        
        alphaView.addSubview(locationButton)
        setupLocationButtonConstraints()
        
        alphaView.addSubview(forecastView)
        setupForecastViewConstraints()
    }
    
    private func setupImageViewConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }
    
    private func setupAlphaViewConstraints() {
        NSLayoutConstraint.activate([
            alphaView.topAnchor.constraint(equalTo: topAnchor),
            alphaView.trailingAnchor.constraint(equalTo: trailingAnchor),
            alphaView.bottomAnchor.constraint(equalTo: bottomAnchor),
            alphaView.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }
    
    private func setupBackButtonConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: (Constants.edge * 4)),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.edge),
            backButton.widthAnchor.constraint(equalToConstant: Constants.BackButton.width),
            backButton.heightAnchor.constraint(equalToConstant: Constants.BackButton.height)
        ])
    }
    
    private func setupLabelCityNameConstraints() {
        NSLayoutConstraint.activate([
            labelCityName.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: (Constants.edge * 2)),
            labelCityName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(Constants.edge * 3)),
            labelCityName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: (Constants.edge * 3)),
            labelCityName.heightAnchor.constraint(equalToConstant: Constants.LabelCityName.height)
        ])
    }
    
    private func setupLineViewConstraints() {
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: labelCityName.bottomAnchor, constant: Constants.edge),
            lineView.trailingAnchor.constraint(equalTo: labelCityName.trailingAnchor),
            lineView.leadingAnchor.constraint(equalTo: labelCityName.leadingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: Constants.LineView.height)
        ])
    }
    
    private func setupStackContainerViewConstraints() {
        NSLayoutConstraint.activate([
            stackContainerView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: (Constants.edge * 2)),
            stackContainerView.trailingAnchor.constraint(equalTo: lineView.trailingAnchor),
            stackContainerView.heightAnchor.constraint(equalToConstant: Constants.CurrentWeatherStackView.height),
            stackContainerView.leadingAnchor.constraint(equalTo: lineView.leadingAnchor)
        ])
    }
    
    private func setupStackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: stackContainerView.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: stackContainerView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: stackContainerView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: stackContainerView.leadingAnchor)
        ])
    }
    
    private func setupStackView() {
        stackView.addArrangedSubview(currentWeatherView)
        stackView.addArrangedSubview(weatherInfoView)
    }
    
    private func setupLocationButtonConstraints() {
        NSLayoutConstraint.activate([
            locationButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(Constants.edge * 5)),
            locationButton.leadingAnchor.constraint(equalTo: stackContainerView.leadingAnchor),
            locationButton.trailingAnchor.constraint(equalTo: stackContainerView.trailingAnchor),
            locationButton.heightAnchor.constraint(equalToConstant: Constants.LocationButton.height)
        ])
    }
    
    private func setupForecastViewConstraints() {
        NSLayoutConstraint.activate([
            forecastView.topAnchor.constraint(equalTo: stackContainerView.bottomAnchor, constant: (Constants.edge * 4)),
            forecastView.trailingAnchor.constraint(equalTo: stackContainerView.trailingAnchor),
            forecastView.bottomAnchor.constraint(equalTo: locationButton.topAnchor, constant: -(Constants.edge * 2)),
            forecastView.leadingAnchor.constraint(equalTo: stackContainerView.leadingAnchor)
        ])
    }

}
