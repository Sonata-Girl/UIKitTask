// SizeShoesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с выбором размера обуви
final class SizeShoesViewController: UIViewController {
    
    // MARK: - Constants
    
    enum Constants {
        static let closeImage = UIImage(named: "close")
        static let sizeLabel = "Выберите размер"
        static let size35 = "35 EU"
        static let size36 = "36 EU"
        static let size37 = "37 EU"
        static let size38 = "38 EU"
        static let size39 = "39 EU"
    }
    
    // MARK: - Private Properties

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(Constants.closeImage, for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let sizeLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.sizeLabel
        label.font = .setVerdanaBold(withSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var size35Button: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setTitle(Constants.size35, for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.titleLabel?.font = .setVerdana(withSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var size36Button: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setTitle(Constants.size36, for: .normal)
        button.titleLabel?.font = .setVerdana(withSize: 16)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var size37Button: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setTitle(Constants.size37, for: .normal)
        button.titleLabel?.font = .setVerdana(withSize: 16)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var size38Button: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setTitle(Constants.size38, for: .normal)
        button.titleLabel?.font = .setVerdana(withSize: 16)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var size39Button: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setTitle(Constants.size39, for: .normal)
        button.titleLabel?.font = .setVerdana(withSize: 16)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let lineView: UIView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(red: 236 / 255, green: 235 / 255, blue: 235 / 255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let lineViewTwo: UIView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(red: 236 / 255, green: 235 / 255, blue: 235 / 255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let lineViewThree: UIView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(red: 236 / 255, green: 235 / 255, blue: 235 / 255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let lineViewFour: UIView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(red: 236 / 255, green: 235 / 255, blue: 235 / 255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let lineViewFive: UIView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(red: 236 / 255, green: 235 / 255, blue: 235 / 255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setConstraints()
    }
    
    // MARK: - Private methods

    private func setupHierarchy() {
        view.backgroundColor = .white
        view.addSubview(closeButton)
        view.addSubview(sizeLabel)
        view.addSubview(size35Button)
        view.addSubview(size36Button)
        view.addSubview(size37Button)
        view.addSubview(size38Button)
        view.addSubview(size39Button)
        view.addSubview(lineView)
        view.addSubview(lineViewTwo)
        view.addSubview(lineViewThree)
        view.addSubview(lineViewFour)
        view.addSubview(lineViewFive)
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
}

// MARK: - Extensions

extension SizeShoesViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 26),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            sizeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 23),
            sizeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            size35Button.topAnchor.constraint(equalTo: view.topAnchor, constant: 77),
            size35Button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            lineView.topAnchor.constraint(equalTo: size35Button.bottomAnchor, constant: 5),
            lineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            lineView.heightAnchor.constraint(equalToConstant: 1),

            size36Button.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 10),
            size36Button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            lineViewTwo.topAnchor.constraint(equalTo: size36Button.bottomAnchor, constant: 5),
            lineViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lineViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            lineViewTwo.heightAnchor.constraint(equalToConstant: 1),

            size37Button.topAnchor.constraint(equalTo: lineViewTwo.bottomAnchor, constant: 5),
            size37Button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            lineViewThree.topAnchor.constraint(equalTo: size37Button.bottomAnchor, constant: 5),
            lineViewThree.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lineViewThree.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            lineViewThree.heightAnchor.constraint(equalToConstant: 1),
            
            size38Button.topAnchor.constraint(equalTo: lineViewThree.bottomAnchor, constant: 5),
            size38Button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            lineViewFour.topAnchor.constraint(equalTo: size38Button.bottomAnchor, constant: 5),
            lineViewFour.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lineViewFour.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            lineViewFour.heightAnchor.constraint(equalToConstant: 1),
            
            size39Button.topAnchor.constraint(equalTo: lineViewFour.bottomAnchor, constant: 5),
            size39Button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            lineViewFive.topAnchor.constraint(equalTo: size39Button.bottomAnchor, constant: 5),
            lineViewFive.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lineViewFive.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            lineViewFive.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
