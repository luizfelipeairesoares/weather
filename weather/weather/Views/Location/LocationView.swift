//
//  LocationView.swift
//  weather
//
//  Created by Luiz Felipe Aires Soares on 16/07/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import UIKit

class LocationView: UIView {
    
    // MARK: - Private Properties
    
    private enum Constants {
        
        static let edge: CGFloat = 8.0
        
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "img_asklocation"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var labelAsk: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hi!\nWe need your location to provide a better experience for you.\n\nBut don't worry, it isn't mandatory!\n\nIf you don't want to give this permission, you can type a city name in the field below and we'll show the weather forecast of that city."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    
    private(set) lazy var buttonAsk: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Allow Access to Location", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        return button
    }()
    
    private(set) lazy var textFieldCity: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter city name"
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .done
        textField.delegate = self
        return textField
    }()
    
    // MARK: - Public Properties
    
    typealias UserTypedTextAction = ((String) -> Void)
    
    var userTappedDoneInKeyboard: UserTypedTextAction?
    
    // MARK: - Init
    
    required init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Functions
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        buttonAsk.layer.cornerRadius = Constants.edge
    }
    
    func addObservers() {
       NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
       NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Private Functions
    
    private func setupSubviews() {
        addSubview(labelAsk)
        setupLabelAskConstraints()
        
        addSubview(imageView)
        setupImageViewConstraints()
        
        addSubview(buttonAsk)
        setupButtonAskConstraints()
        
        addSubview(textFieldCity)
        setupTextFieldConstraints()
    }
    
    private func setupLabelAskConstraints() {
        NSLayoutConstraint.activate([
            labelAsk.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -(Constants.edge * 8)),
            labelAsk.leadingAnchor.constraint(equalTo: leadingAnchor, constant: (Constants.edge * 2)),
            labelAsk.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(Constants.edge * 2)),
        ])
    }
    
    private func setupImageViewConstraints() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.bottomAnchor.constraint(equalTo: labelAsk.topAnchor, constant: -(Constants.edge * 4))
        ])
    }
    
    private func setupButtonAskConstraints() {
        NSLayoutConstraint.activate([
            buttonAsk.topAnchor.constraint(equalTo: labelAsk.bottomAnchor, constant: (Constants.edge * 4)),
            buttonAsk.leadingAnchor.constraint(equalTo: leadingAnchor, constant: (Constants.edge * 2)),
            buttonAsk.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(Constants.edge * 2)),
            buttonAsk.heightAnchor.constraint(equalToConstant: 44.0)
        ])
    }
    
    private func setupTextFieldConstraints() {
        NSLayoutConstraint.activate([
            textFieldCity.topAnchor.constraint(equalTo: buttonAsk.bottomAnchor, constant: (Constants.edge * 2)),
            textFieldCity.leadingAnchor.constraint(equalTo: leadingAnchor, constant: (Constants.edge * 2)),
            textFieldCity.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(Constants.edge * 2)),
            textFieldCity.heightAnchor.constraint(equalToConstant: 44.0)
        ])
    }
       
    @objc private func keyboardWillShow(_ notification: Notification) {
        layoutIfNeeded()
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveLinear, animations: {
            self.frame.origin.y -= 80.0
            self.layoutIfNeeded()
        })
    }
       
    @objc private func keyboardWillHide(_ notification: Notification) {
        layoutIfNeeded()
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveLinear, animations: {
            self.frame.origin.y += 80.0
            self.layoutIfNeeded()
        })
    }

}

// MARK: - UITextFieldDelegate

extension LocationView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        if let text = textField.text, !text.isEmpty {
            userTappedDoneInKeyboard?(text)
        }
        return true
    }
    
}
