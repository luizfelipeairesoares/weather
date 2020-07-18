//
//  ForecastCollectionViewCell.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 17/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Private Properties
    
    private enum Constants {
    
        static let edge: CGFloat = 8.0
        
        enum WeekdayLabel {
            static let fontSize: CGFloat = 16.0
            static let height: CGFloat = 24.0
        }
        
    }
    
    private lazy var weekdayLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: Constants.WeekdayLabel.fontSize)
        label.textColor = .white
        label.shadowColor = UIColor.black.withAlphaComponent(0.25)
        label.shadowOffset = CGSize(width: 2.0, height: 2.0)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8.0
        return stackView
    }()
    
    // MARK: - Public Properties
    
    static let identifier: String = String(describing: self)
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Functions
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
    // MARK: - Public Functions
    
    func configureCell(_ weather: OWeather) {
        weekdayLabel.text = weather.date?.weekdayString()
        
        if let weatherDescription = weather.weatherDescription.first {
            let forecastInfo = ForecastInfoView()
            forecastInfo.configureView(with: .weather(icon: weatherDescription.iconUrl, description: weatherDescription.main))
            stackView.addArrangedSubview(forecastInfo)
        }
        
        if let min = weather.temp.min, let max = weather.temp.max {
            let forecastInfo = ForecastInfoView()
            forecastInfo.configureView(with: .minMaxTemperatures(min: min, max: max))
            stackView.addArrangedSubview(forecastInfo)
        }
        
        if let humidity = weather.humidity {
            let forecastInfo = ForecastInfoView()
            forecastInfo.configureView(with: .humidity(humidity: humidity))
            stackView.addArrangedSubview(forecastInfo)
        }
        
        if let windSpeed = weather.windSpeed {
            let forecastInfo = ForecastInfoView()
            forecastInfo.configureView(with: .windSpeed(speed: windSpeed))
            stackView.addArrangedSubview(forecastInfo)
        }
    }
    
    // MARK: - Private Functions
    
    private func setupSubviews() {
        addSubview(weekdayLabel)
        setupWeekDayLabelConstraints()
        
        addSubview(stackView)
        setupStackViewConstraints()
    }
    
    private func setupWeekDayLabelConstraints() {
        NSLayoutConstraint.activate([
            weekdayLabel.topAnchor.constraint(equalTo: topAnchor),
            weekdayLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            weekdayLabel.heightAnchor.constraint(equalToConstant: Constants.WeekdayLabel.height),
            weekdayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.edge),
        ])
    }
    
    private func setupStackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: weekdayLabel.bottomAnchor, constant: Constants.edge),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }
    
}
