//
//  ForecastInfoView.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 17/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import UIKit
import Kingfisher

enum ForecastInfo {
    
    case minMaxTemperatures(min: Double?, max: Double?)
    case windSpeed(speed: Double)
    case humidity(humidity: Int)
    case weather(icon: URL?, description: String)
    
    
}

class ForecastInfoView: UIView {

    // MARK: - Private Properties
    
    private enum Constants {
        
        static let edge: CGFloat = 8.0
        
    }
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 0.0
        return stackView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 2.0
        return stackView
    }()
    
    // MARK: - Init
    
    required init() {
        super.init(frame: .zero)
        backgroundColor = UIColor.white.withAlphaComponent(0.24)
        setupSubviews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View functions
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = Constants.edge
        layer.masksToBounds = true
    }
    
    // MARK: - Public Functions
    
    public func configureView(with info: ForecastInfo) {
        switch info {
        case .weather(let icon, let description):
            imageView.kf.setImage(with: icon)
            horizontalStackView.addArrangedSubview(createLabel(with: description))
        case .minMaxTemperatures(let min, let max):
            imageView.image = UIImage(named: "icon_thermometer")
            if let maxTemp = max {
                horizontalStackView.addArrangedSubview(createLabel(with: String(format: "%2.1fº", maxTemp), fontSize: 14.0))
            }
            if let minTemp = min {
                let label = createLabel(with: String(format: "%2.1fº", minTemp), fontSize: 14.0)
                label.textColor = UIColor.white.withAlphaComponent(0.72)
                horizontalStackView.addArrangedSubview(label)
            }
        case .windSpeed(let speed):
            imageView.image = UIImage(named: "icon_wind")
            horizontalStackView.addArrangedSubview(createLabel(with: String(format: "%2.1f km/h", speed * 3.6)))
        case .humidity(let humidity):
            imageView.image = UIImage(named: "icon_humidity")
            horizontalStackView.addArrangedSubview(createLabel(with: "\(humidity)%"))
        }
    }
    
    // MARK: - Private Functions
    
    private func setupSubviews() {
        addSubview(verticalStackView)
        setupVerticalStackViewConstraints()
        verticalStackView.addArrangedSubview(imageView)
        verticalStackView.addArrangedSubview(horizontalStackView)
    }
    
    private func setupVerticalStackViewConstraints() {
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.edge),
            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    private func createLabel(with text: String, fontSize: CGFloat = 16.0) -> UILabel {
        let label = UILabel(frame: .zero)
        label.text = text
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textColor = .white
        label.shadowColor = UIColor.black.withAlphaComponent(0.24)
        label.shadowOffset = CGSize(width: 2.0, height: 2.0)
        label.textAlignment = .center
        return label
    }
    
}
