// RecommendationView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка для отображения сторис
final class RecommendationView: UIView {
    // MARK: Constants

    private enum Constants {
        static let subscribeButtonTitle = "Подписаться"
    }

    // MARK: Visual Components

    private let mainImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 55
        return imageView
    }()

    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .setVerdana(withSize: 10)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()

    private let subscribeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.subscribeButtonTitle, for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .setVerdanaBold(withSize: 10)
        button.backgroundColor = .appBlue
        button.layer.cornerRadius = 8
        return button
    }()

    private let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(.closeButton, for: .normal)
        button.tintColor = .black
        return button
    }()

    // MARK: Privates Properties

    private var model: User?

    // MARK: Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHierarchy()
        setupUI()
    }

    // MARK: Public methods

    func configureView(recommendation: User) {
        model = recommendation
        guard let model else { return }
        mainImage.image = UIImage(named: model.avatarImage)
        userNameLabel.text = model.name
    }

    // MARK: Private methods

    private func setupHierarchy() {
        [
            closeButton,
            mainImage,
            userNameLabel,
            subscribeButton
        ].forEach { addSubview($0) }
    }

    private func setupUI() {
        backgroundColor = .white

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            closeButton.widthAnchor.constraint(equalToConstant: 7),
            closeButton.heightAnchor.constraint(equalToConstant: 7),
        ])

        NSLayoutConstraint.activate([
            mainImage.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            mainImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
            mainImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35),
            mainImage.heightAnchor.constraint(equalToConstant: 115),
            mainImage.widthAnchor.constraint(equalToConstant: 115)
        ])

        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 5),
            userNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
            userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35),
            userNameLabel.heightAnchor.constraint(equalToConstant: 12),
            userNameLabel.widthAnchor.constraint(equalTo: mainImage.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            subscribeButton.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8),
            subscribeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            subscribeButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14),
            subscribeButton.widthAnchor.constraint(equalToConstant: 165),
//            subscribeButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
