//
//  WeatherForecastView.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 17/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import UIKit

class WeatherForecastView: UIView {

    // MARK: - Private Properties
    
    private enum Constants {
        
        static let edge: CGFloat = 8.0
        
        enum Label7Days {
            static let fontSize: CGFloat = 20.0
            static let height: CGFloat = 24.0
        }
        
        enum LineView {
            static let height: CGFloat = 1.0
        }
    }
    
    private(set) lazy var label7days: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: Constants.Label7Days.fontSize)
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
    
    private(set) lazy var collectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(ForecastCollectionViewCell.self, forCellWithReuseIdentifier: ForecastCollectionViewCell.identifier)
        return collectionView
    }()
    
    // MARK: - Init
    
    required init() {
        super.init(frame: .zero)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Functions
    
    private func setupSubviews() {
        addSubview(label7days)
        setupLabel7DaysConstraints()
        
        addSubview(lineView)
        setupLineViewConstraints()
        
        addSubview(collectionView)
        setupCollectionViewConstraints()
    }
    
    private func setupLabel7DaysConstraints() {
        NSLayoutConstraint.activate([
            label7days.topAnchor.constraint(equalTo: topAnchor),
            label7days.trailingAnchor.constraint(equalTo: trailingAnchor),
            label7days.leadingAnchor.constraint(equalTo: leadingAnchor),
            label7days.heightAnchor.constraint(equalToConstant: Constants.Label7Days.height)
        ])
    }
    
    private func setupLineViewConstraints() {
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: label7days.bottomAnchor, constant: Constants.edge),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: Constants.LineView.height)
        ])
    }
    
    private func setupCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: (Constants.edge * 2)),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(Constants.edge * 2)),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }

}
