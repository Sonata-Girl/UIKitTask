// ProductOptionsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Степени поджарки кофе
enum RoastingType {
    case high(image: UIImage, title: String)
    case light(image: UIImage, title: String)
}

/// Настройка и выбор доп.ингредиентов продукта для заказа, пока только Кофе
class ProductOptionsViewController: UIViewController {
    // MARK: - Types

    // MARK: - Constants

    // MARK: - IBOutlet

    // MARK: - Visual Components

    private let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .appBeige
        view.layer.cornerRadius = 30
        return view
    }()

    private let productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill // заполнить
        imageView.image = .americano
        return imageView
    }()

    private lazy var leftButtonBar: UIButton = {
        var leftButtonBar = UIButton()
        leftButtonBar.setImage(.backArrow, for: .normal)
        leftButtonBar.backgroundColor = .appLightSky
        leftButtonBar.layer.cornerRadius = 23
        leftButtonBar.frame.size.height = 44
        leftButtonBar.frame.size.width = 44
        leftButtonBar.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        return leftButtonBar
    }()

    private lazy var rightButtonBar: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        button.tintColor = .label
        button.addTarget(nil, action: #selector(shareButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var typeProductSegmented: UISegmentedControl = {
        let segmented = UISegmentedControl(items: products.map(\.type))
        segmented.selectedSegmentIndex = 0
        segmented.backgroundColor = .systemGray6
        segmented.addTarget(self, action: #selector(productChanged), for: .valueChanged)
        return segmented
    }()

    private let modificationLabel: UILabel = {
        let label = UILabel()
        label.text = "Модификация"
        label.font = .setVerdanaBold(withSize: 18)
        label.textColor = .label
        return label
    }()

    private let roastingView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 20
        return view
    }()

    private let roastingButton: UIButton = {
        let button = UIButton()
        button.setImage(.highRoasting, for: .normal)
        return button
    }()

    private let roastingLabel: UILabel = {
        let label = UILabel()
        label.text = "Темная \nобжарка"
        label.font = .setVerdana(withSize: 14)
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    private let extraOptionsView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 20
        return view
    }()

    private let extraOptionsButton: UIButton = {
        let button = UIButton()
        button.setImage(.plus, for: .normal)
        return button
    }()

    private let extraOptionsLabel: UILabel = {
        let label = UILabel()
        label.text = "Дополнительные \nингредіенты"
        label.font = .setVerdana(withSize: 14)
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "Цѣна - 100 руб"
        label.font = .setVerdanaBold(withSize: 18)
        label.textColor = .label
        label.textAlignment = .right
        return label
    }()

    private let orderButton: UIButton = DefaultButton(text: "Заказать")

    // MARK: - Public Properties

    // MARK: - Private Properties

    private var products: [Coffee] = [
        Coffee(type: "Американо", imageName: "americano"),
        Coffee(type: "Капучино", imageName: "cappuccino"),
        Coffee(type: "Латте", imageName: "latte")
    ]

    // MARK: - Initializers

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupUI()
        setupNavigationBar()
    }

    private func setupHierarchy() {
        [
            topView,
            typeProductSegmented,
            modificationLabel,
            roastingView,
            extraOptionsView,
            priceLabel,
            orderButton
        ].forEach { view.addSubview($0) }

        [
            productImage,
//            shareButton
        ].forEach { topView.addSubview($0) }

        [
            roastingButton,
            roastingLabel
        ].forEach { roastingView.addSubview($0) }

        [
            extraOptionsButton,
            extraOptionsLabel
        ].forEach { extraOptionsView.addSubview($0) }
    }

    private func setupUI() {
        view.backgroundColor = .white

        topView.frame = .init(x: 0, y: 0, width: 375, height: 346)

        typeProductSegmented.frame = .init(x: 15, y: 368, width: 345, height: 44)

        modificationLabel.frame = .init(x: 15, y: 432, width: 200, height: 30)

        roastingView.frame = .init(x: 15, y: 482, width: 165, height: 165)
        roastingButton.frame = .init(x: 31, y: 17, width: 100, height: 100)
        roastingLabel.frame = .init(x: 0, y: 117, width: 165, height: 37)

        extraOptionsView.frame = .init(x: 195, y: 482, width: 165, height: 165)
        extraOptionsButton.frame = .init(x: 31, y: 17, width: 100, height: 100)
        extraOptionsLabel.frame = .init(x: 0, y: 117, width: 165, height: 37)

        priceLabel.frame = .init(x: 15, y: 669, width: 345, height: 30)

        orderButton.frame = .init(x: 15, y: 717, width: 345, height: 53)

        productImage.frame = .init(x: 112, y: 128, width: 150, height: 150)
    }

    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButtonBar)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButtonBar)
    }

    // MARK: - Public methods

    // MARK: - IBAction или @objc (not private)

    // MARK: - Private Methods

    @objc private func productChanged(sender: UISegmentedControl) {
        if sender == typeProductSegmented {
            let segmentedIndex = sender.selectedSegmentIndex
            productImage.image = UIImage(named: products[segmentedIndex].imageName)
        }
    }

    @objc private func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func shareButtonTapped() {
        let items = ["Лови промокод roadmaplove на любой напиток из Кофейнов"]

        let shareController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(shareController, animated: true)
    }

    // MARK: - IBAction или @objc (private)
}
