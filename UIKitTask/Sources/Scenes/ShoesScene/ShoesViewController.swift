// ShoesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для передачи данных
protocol ShoesDelegate: AnyObject {
    func addShoes(sender: UIButton)
}

/// Экран с выбором обуви
final class ShoesViewController: UIViewController {
    weak var delegate: ShoesDelegate?

    // MARK: - Constants

    enum Constants {
        static let titleOfNavigation = "Обувь"
        static let shoesOneViewCost = "2250 ₽"
        static let shoesTwoViewCost = "4250 ₽"
        static let shoesThreeViewCost = "5750 ₽"
        static let shoesFourViewCost = "3500 ₽"
        static let shoesFiveViewCost = "5750 ₽"
        static let shoesImageOne = UIImage(named: "shoes_one")
        static let shoesImageTwo = UIImage(named: "shoes_two")
        static let shoesImageThree = UIImage(named: "shoes_three")
        static let shoesImageFour = UIImage(named: "shoes_four")
        static let shoesImageFive = UIImage(named: "shoes_five")
        static let basket = UIImage(named: "basket_noactive")
        static let basketActive = UIImage(named: "basket_active")
    }

    // MARK: - Private Properties

    private let shoesOneView: UIView = {
        let view = UIImageView()
        view.backgroundColor = .appBackgroundViewColor()
        view.layer.cornerRadius = 20
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let shoesOneImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.shoesImageOne
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let shoesOneLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.shoesOneViewCost
        label.font = .setVerdanaBold(withSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var basketOneButton: UIButton = {
        let button = UIButton()
        button.setImage(Constants.basket, for: .normal)
        button.addTarget(self, action: #selector(basketButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let shoesTwoView: UIView = {
        let view = UIImageView()
        view.backgroundColor = .appBackgroundViewColor()
        view.layer.cornerRadius = 20
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let shoesTwoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.shoesImageTwo
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let shoesTwoLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.shoesTwoViewCost
        label.font = .setVerdanaBold(withSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var basketTwoButton: UIButton = {
        let button = UIButton()
        button.setImage(Constants.basket, for: .normal)
        button.addTarget(self, action: #selector(basketButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let shoesThreeView: UIView = {
        let view = UIImageView()
        view.backgroundColor = .appBackgroundViewColor()
        view.layer.cornerRadius = 20
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let shoesThreeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.shoesImageThree
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let shoesThreeLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.shoesThreeViewCost
        label.font = .setVerdanaBold(withSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var basketThreeButton: UIButton = {
        let button = UIButton()
        button.setImage(Constants.basket, for: .normal)
        button.addTarget(self, action: #selector(basketButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let shoesFourView: UIView = {
        let view = UIImageView()
        view.backgroundColor = .appBackgroundViewColor()
        view.layer.cornerRadius = 20
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let shoesFourImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.shoesImageFour
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let shoesFourLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.shoesFourViewCost
        label.font = .setVerdanaBold(withSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var basketFourButton: UIButton = {
        let button = UIButton()
        button.setImage(Constants.basket, for: .normal)
        button.addTarget(self, action: #selector(basketButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let shoesFiveView: UIView = {
        let view = UIImageView()
        view.backgroundColor = .appBackgroundViewColor()
        view.layer.cornerRadius = 20
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let shoesFiveImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.shoesImageFive
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let shoesFiveLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.shoesFiveViewCost
        label.font = .setVerdanaBold(withSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var basketFiveButton: UIButton = {
        let button = UIButton()
        button.setImage(Constants.basket, for: .normal)
        button.addTarget(self, action: #selector(basketButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setConstraints()
        setNavigationBar()
    }

    // MARK: - Private methods

    private func setupHierarchy() {
        view.backgroundColor = .white
        view.addSubview(shoesOneView)
        shoesOneView.addSubview(shoesOneImage)
        shoesOneView.addSubview(shoesOneLabel)
        shoesOneView.addSubview(basketOneButton)
        view.addSubview(shoesTwoView)
        shoesTwoView.addSubview(shoesTwoImage)
        shoesTwoView.addSubview(shoesTwoLabel)
        shoesTwoView.addSubview(basketTwoButton)
        view.addSubview(shoesThreeView)
        shoesThreeView.addSubview(shoesThreeImage)
        shoesThreeView.addSubview(shoesThreeLabel)
        shoesThreeView.addSubview(basketThreeButton)
        view.addSubview(shoesFourView)
        shoesFourView.addSubview(shoesFourImage)
        shoesFourView.addSubview(shoesFourLabel)
        shoesFourView.addSubview(basketFourButton)
        view.addSubview(shoesFiveView)
        shoesFiveView.addSubview(shoesFiveImage)
        shoesFiveView.addSubview(shoesFiveLabel)
        shoesFiveView.addSubview(basketFiveButton)
    }

    private func setNavigationBar() {
        navigationItem.title = Constants.titleOfNavigation
        navigationController?.navigationBar.tintColor = .black
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    private func addShoes(sender: UIButton) {
        if sender == basketOneButton {
            print("Добавлена обувь 1")
        } else if sender == basketTwoButton {
            print("Добавлена обувь 2")
        } else if sender == basketThreeButton {
            print("Добавлена обувь 3")
        } else if sender == basketFourButton {
            print("Добавлена обувь 4")
        } else if sender == basketFiveButton {
            print("Добавлена обувь 5")
        }
        delegate?.addShoes(sender: sender)
    }

    @objc private func basketButtonTapped(sender: UIButton) {
        if sender.currentImage == Constants.basket {
            sender.setImage(Constants.basketActive, for: .normal)
            present(SizeShoesViewController(), animated: true)
            SizeShoesViewController().modalPresentationStyle = .automatic
            addShoes(sender: sender)
        } else {
            sender.setImage(Constants.basket, for: .normal)
        }
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            shoesOneView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 33),
            shoesOneView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            shoesOneView.heightAnchor.constraint(equalToConstant: 157),
            shoesOneView.widthAnchor.constraint(equalToConstant: 157),

            shoesOneImage.centerXAnchor.constraint(equalTo: shoesOneView.centerXAnchor),
            shoesOneImage.centerYAnchor.constraint(equalTo: shoesOneView.centerYAnchor),

            basketOneButton.leadingAnchor.constraint(equalTo: shoesOneView.leadingAnchor, constant: 126),
            basketOneButton.topAnchor.constraint(equalTo: shoesOneView.topAnchor, constant: 11.5),
            basketOneButton.trailingAnchor.constraint(equalTo: shoesOneView.trailingAnchor, constant: -11),

            shoesOneLabel.trailingAnchor.constraint(equalTo: shoesOneView.trailingAnchor, constant: -9),
            shoesOneLabel.topAnchor.constraint(equalTo: shoesOneView.topAnchor, constant: 133),

            shoesTwoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 33),
            shoesTwoView.leadingAnchor.constraint(equalTo: shoesOneView.trailingAnchor, constant: 21),
            shoesTwoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            shoesTwoView.heightAnchor.constraint(equalToConstant: 157),
            shoesTwoView.widthAnchor.constraint(equalToConstant: 157),

            shoesTwoImage.centerXAnchor.constraint(equalTo: shoesTwoView.centerXAnchor),
            shoesTwoImage.centerYAnchor.constraint(equalTo: shoesTwoView.centerYAnchor),

            basketTwoButton.leadingAnchor.constraint(equalTo: shoesTwoView.leadingAnchor, constant: 126),
            basketTwoButton.topAnchor.constraint(equalTo: shoesTwoView.topAnchor, constant: 11.5),
            basketTwoButton.trailingAnchor.constraint(equalTo: shoesTwoView.trailingAnchor, constant: -11),

            shoesTwoLabel.trailingAnchor.constraint(equalTo: shoesTwoView.trailingAnchor, constant: -9),
            shoesTwoLabel.topAnchor.constraint(equalTo: shoesTwoView.topAnchor, constant: 133),

            shoesThreeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            shoesThreeView.topAnchor.constraint(equalTo: shoesOneView.bottomAnchor, constant: 16),
            shoesThreeView.heightAnchor.constraint(equalToConstant: 157),
            shoesThreeView.widthAnchor.constraint(equalToConstant: 157),

            shoesThreeImage.centerXAnchor.constraint(equalTo: shoesThreeView.centerXAnchor),
            shoesThreeImage.centerYAnchor.constraint(equalTo: shoesThreeView.centerYAnchor),

            basketThreeButton.leadingAnchor.constraint(equalTo: shoesThreeView.leadingAnchor, constant: 126),
            basketThreeButton.topAnchor.constraint(equalTo: shoesThreeView.topAnchor, constant: 11.5),
            basketThreeButton.trailingAnchor.constraint(equalTo: shoesThreeView.trailingAnchor, constant: -11),

            shoesThreeLabel.trailingAnchor.constraint(equalTo: shoesThreeView.trailingAnchor, constant: -9),
            shoesThreeLabel.topAnchor.constraint(equalTo: shoesThreeView.topAnchor, constant: 133),

            shoesFourView.topAnchor.constraint(equalTo: shoesTwoView.bottomAnchor, constant: 16),
            shoesFourView.leadingAnchor.constraint(equalTo: shoesThreeView.trailingAnchor, constant: 21),
            shoesFourView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            shoesFourView.heightAnchor.constraint(equalToConstant: 157),
            shoesFourView.widthAnchor.constraint(equalToConstant: 157),

            shoesFourImage.centerXAnchor.constraint(equalTo: shoesFourView.centerXAnchor),
            shoesFourImage.centerYAnchor.constraint(equalTo: shoesFourView.centerYAnchor),

            basketFourButton.leadingAnchor.constraint(equalTo: shoesFourView.leadingAnchor, constant: 126),
            basketFourButton.topAnchor.constraint(equalTo: shoesFourView.topAnchor, constant: 11.5),
            basketFourButton.trailingAnchor.constraint(equalTo: shoesFourView.trailingAnchor, constant: -11),

            shoesFourLabel.trailingAnchor.constraint(equalTo: shoesFourView.trailingAnchor, constant: -9),
            shoesFourLabel.topAnchor.constraint(equalTo: shoesFourView.topAnchor, constant: 133),

            shoesFiveView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            shoesFiveView.topAnchor.constraint(equalTo: shoesThreeView.bottomAnchor, constant: 16),
            shoesFiveView.heightAnchor.constraint(equalToConstant: 157),
            shoesFiveView.widthAnchor.constraint(equalToConstant: 157),

            shoesFiveImage.centerXAnchor.constraint(equalTo: shoesFiveView.centerXAnchor),
            shoesFiveImage.centerYAnchor.constraint(equalTo: shoesFiveView.centerYAnchor),

            basketFiveButton.leadingAnchor.constraint(equalTo: shoesFiveView.leadingAnchor, constant: 126),
            basketFiveButton.topAnchor.constraint(equalTo: shoesFiveView.topAnchor, constant: 11.5),
            basketFiveButton.trailingAnchor.constraint(equalTo: shoesFiveView.trailingAnchor, constant: -11),

            shoesFiveLabel.trailingAnchor.constraint(equalTo: shoesFiveView.trailingAnchor, constant: -9),
            shoesFiveLabel.topAnchor.constraint(equalTo: shoesFiveView.topAnchor, constant: 133)
        ])
    }
}
