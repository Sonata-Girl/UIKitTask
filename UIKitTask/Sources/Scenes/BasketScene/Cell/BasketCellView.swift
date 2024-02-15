// BasketCellView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Кастомный вью ячейка товара в корзине
class BasketCellView: UIView {
    // MARK: Types

    private enum Constants {
        static let screenTitle = "Корзина"

        static let orderButtonTitle = "Оформить заказ - 4250 ₽"
        static let priceText = "4250 ₽"
        static let goodNameTitle = "Женские ботинки"
        static let countTitle = "Количество"
        static let sizeTitle = "Размер"
        static let priceTitle = "Цена"
        static let firstLabelText = "35"
        static let secondLabelText = "36"
        static let thirdLabelText = "37"
        static let fourthLabelText = "38"
        static let fifthLabelText = "39"
    }

    // MARK: Visual Components

    private let goodImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        imageView.image = .bootBlack
        imageView.backgroundColor = .appLightGray
        imageView.layer.cornerRadius = 20
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    private lazy var basketButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.basketIcon, for: .normal)
        button.addTarget(self, action: #selector(deleteGood), for: .touchUpInside)
        return button
    }()

    private let plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.miniPlus, for: .normal)
        button.backgroundColor = .appLightPink
        button.tintColor = .label
        button.layer.cornerRadius = 8
        return button
    }()

    private let minusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.miniMinus, for: .normal)
        button.backgroundColor = .appLightPink
        button.tintColor = .label
        button.layer.cornerRadius = 8
        return button
    }()

    private let goodNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.goodNameTitle
        label.font = .setVerdana(withSize: 12)
        label.textColor = .label
        return label
    }()

    private let countTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.countTitle
        label.font = .setVerdana(withSize: 12)
        label.textColor = .label
        return label
    }()

    private let countGoodsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1"
        label.font = .setVerdana(withSize: 12)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()

    private let sizeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.sizeTitle
        label.font = .setVerdana(withSize: 12)
        label.textColor = .label
        return label
    }()

    private let priceTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.priceTitle
        label.font = .setVerdana(withSize: 12)
        label.textColor = .label
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.priceText
        label.font = .setVerdanaBold(withSize: 10)
        label.textColor = .label
        return label
    }()

    private let firstSizeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.firstLabelText
        label.font = .setVerdana(withSize: 10)
        label.textColor = .label
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.backgroundColor = .appLightPink
        return label
    }()

    private let secondSizeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.secondLabelText
        label.font = .setVerdana(withSize: 10)
        label.textColor = .label
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.backgroundColor = .appLightPink
        return label
    }()

    private let thirdSizeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.thirdLabelText
        label.font = .setVerdana(withSize: 10)
        label.textColor = .label
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.backgroundColor = .appLightPink
        return label
    }()

    private let fourthSizeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.fourthLabelText
        label.font = .setVerdana(withSize: 10)
        label.textColor = .label
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.backgroundColor = .appLightPink
        return label
    }()

    private let fifthSizeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.fifthLabelText
        label.font = .setVerdana(withSize: 10)
        label.textColor = .label
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.backgroundColor = .appLightPink
        return label
    }()

    // MARK: Public Properties

    var goodDeletedHandle: ((String, String) -> ())?

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

    // MARK: Private methods

    private func setupHierarchy() {
        [
            goodImage,
            goodNameLabel,
            countTitleLabel,
            plusButton,
            minusButton,
            countGoodsLabel,
            sizeTitleLabel,
            priceTitleLabel,
            priceLabel,
            firstSizeLabel,
            secondSizeLabel,
            thirdSizeLabel,
            fourthSizeLabel,
            fifthSizeLabel
        ].forEach { addSubview($0) }

        goodImage.addSubview(basketButton)
    }

    private func setupUI() {
        NSLayoutConstraint.activate([
            goodImage.topAnchor.constraint(equalTo: topAnchor),
            bottomAnchor.constraint(equalTo: goodImage.bottomAnchor),
            goodImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            goodImage.widthAnchor.constraint(equalToConstant: 157),
            goodImage.heightAnchor.constraint(equalToConstant: 157)
        ])

        NSLayoutConstraint.activate([
            basketButton.topAnchor.constraint(equalTo: goodImage.topAnchor, constant: 13),
            goodImage.trailingAnchor.constraint(equalTo: basketButton.trailingAnchor, constant: 10),
            basketButton.widthAnchor.constraint(equalToConstant: 20),
            basketButton.heightAnchor.constraint(equalToConstant: 20)
        ])

        NSLayoutConstraint.activate([
            goodNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            goodNameLabel.leadingAnchor.constraint(equalTo: goodImage.trailingAnchor, constant: 16),
            goodNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20),
            goodNameLabel.heightAnchor.constraint(equalToConstant: 15)
        ])

        NSLayoutConstraint.activate([
            countTitleLabel.topAnchor.constraint(equalTo: goodNameLabel.bottomAnchor, constant: 12),
            countTitleLabel.leadingAnchor.constraint(equalTo: goodImage.trailingAnchor, constant: 16),
            countTitleLabel.widthAnchor.constraint(equalToConstant: 40),
            countTitleLabel.heightAnchor.constraint(equalToConstant: 15)
        ])

        NSLayoutConstraint.activate([
            minusButton.topAnchor.constraint(equalTo: goodNameLabel.bottomAnchor, constant: 12),
            minusButton.leadingAnchor.constraint(equalTo: countTitleLabel.trailingAnchor, constant: 3),
            minusButton.heightAnchor.constraint(equalToConstant: 15),
            minusButton.widthAnchor.constraint(equalToConstant: 15)
        ])

        NSLayoutConstraint.activate([
            countGoodsLabel.topAnchor.constraint(equalTo: goodNameLabel.bottomAnchor, constant: 12),
            countGoodsLabel.leadingAnchor.constraint(equalTo: minusButton.trailingAnchor, constant: 3),
            countGoodsLabel.heightAnchor.constraint(equalToConstant: 15),
            countGoodsLabel.widthAnchor.constraint(equalToConstant: 15)
        ])

        NSLayoutConstraint.activate([
            plusButton.topAnchor.constraint(equalTo: goodNameLabel.bottomAnchor, constant: 12),
            plusButton.leadingAnchor.constraint(equalTo: countGoodsLabel.trailingAnchor, constant: 3),
            trailingAnchor.constraint(equalTo: plusButton.trailingAnchor, constant: 27),
            plusButton.heightAnchor.constraint(equalToConstant: 15),
            plusButton.widthAnchor.constraint(equalToConstant: 15)
        ])

        NSLayoutConstraint.activate([
            sizeTitleLabel.topAnchor.constraint(equalTo: countTitleLabel.bottomAnchor, constant: 12),
            sizeTitleLabel.leadingAnchor.constraint(equalTo: goodImage.trailingAnchor, constant: 16),
            trailingAnchor.constraint(equalTo: sizeTitleLabel.trailingAnchor, constant: 20),
            sizeTitleLabel.heightAnchor.constraint(equalToConstant: 15)
        ])

        NSLayoutConstraint.activate([
            firstSizeLabel.topAnchor.constraint(equalTo: sizeTitleLabel.bottomAnchor, constant: 10),
            firstSizeLabel.leadingAnchor.constraint(equalTo: goodImage.trailingAnchor, constant: 22),
            firstSizeLabel.heightAnchor.constraint(equalToConstant: 17),
            firstSizeLabel.widthAnchor.constraint(equalToConstant: 31)
        ])

        NSLayoutConstraint.activate([
            secondSizeLabel.topAnchor.constraint(equalTo: sizeTitleLabel.bottomAnchor, constant: 10),
            secondSizeLabel.leadingAnchor.constraint(equalTo: firstSizeLabel.trailingAnchor, constant: 4),
            secondSizeLabel.heightAnchor.constraint(equalToConstant: 17),
            secondSizeLabel.widthAnchor.constraint(equalToConstant: 31)
        ])

        NSLayoutConstraint.activate([
            thirdSizeLabel.topAnchor.constraint(equalTo: sizeTitleLabel.bottomAnchor, constant: 10),
            thirdSizeLabel.leadingAnchor.constraint(equalTo: secondSizeLabel.trailingAnchor, constant: 4),
            thirdSizeLabel.heightAnchor.constraint(equalToConstant: 17),
            thirdSizeLabel.widthAnchor.constraint(equalToConstant: 31)
        ])

        NSLayoutConstraint.activate([
            fourthSizeLabel.topAnchor.constraint(equalTo: sizeTitleLabel.bottomAnchor, constant: 10),
            fourthSizeLabel.leadingAnchor.constraint(equalTo: thirdSizeLabel.trailingAnchor, constant: 4),
            trailingAnchor.constraint(equalTo: fourthSizeLabel.trailingAnchor, constant: 39),
            fourthSizeLabel.heightAnchor.constraint(equalToConstant: 17),
            fourthSizeLabel.widthAnchor.constraint(equalToConstant: 31)
        ])

        NSLayoutConstraint.activate([
            fifthSizeLabel.topAnchor.constraint(equalTo: firstSizeLabel.bottomAnchor, constant: 4),
            fifthSizeLabel.leadingAnchor.constraint(equalTo: goodImage.trailingAnchor, constant: 22),
            fifthSizeLabel.heightAnchor.constraint(equalToConstant: 17),
            fifthSizeLabel.widthAnchor.constraint(equalToConstant: 31)
        ])

        NSLayoutConstraint.activate([
            priceTitleLabel.topAnchor.constraint(equalTo: fifthSizeLabel.bottomAnchor, constant: 7),
            priceTitleLabel.leadingAnchor.constraint(equalTo: goodImage.trailingAnchor, constant: 16),
            priceTitleLabel.heightAnchor.constraint(equalToConstant: 15),
            priceTitleLabel.widthAnchor.constraint(equalToConstant: 32)
        ])

        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: fifthSizeLabel.bottomAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: priceTitleLabel.trailingAnchor, constant: 90),
            trailingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 2),
            priceLabel.heightAnchor.constraint(equalToConstant: 12),
            priceLabel.widthAnchor.constraint(equalToConstant: 63)
        ])
    }

    @objc private func deleteGood() {
        goodDeletedHandle?(goodNameLabel.text ?? "", goodNameLabel.text ?? "")
    }
}
