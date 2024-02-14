// ProductOptionsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Степени поджарки кофе
enum RoastingType {
    case high
    case light

    var image: UIImage {
        switch self {
        case .high:
            return .highRoasting
        case .light:
            return .lightRoasting
        }
    }

    var title: String {
        switch self {
        case .high:
            return "Темная \nобжарка"
        case .light:
            return "Свѣтлая \nобжарка"
        }
    }
}

/// Настройка и выбор доп.ингредиентов продукта для заказа, пока только Кофе
final class ProductOptionsViewController: UIViewController {
    // MARK: - Visual Components

    private let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .appBeige
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
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
        button.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
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

    private lazy var roastingButton: DefaultBigButton = {
        let button = DefaultBigButton()
        button.configureView(typeRoasting: .high)
        button.addTarget(self, action: #selector(roastingPressed), for: .touchUpInside)
        return button
    }()

    private lazy var extraOptionsButton: DefaultBigButton = {
        let button = DefaultBigButton()
        button.configureView(
            title: "Дополнительные \nингредіенты",
            imageName: "plus"
        )
        button.addTarget(self, action: #selector(extraOptionsPressed), for: .touchUpInside)
        return button
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "Цѣна - 100 руб"
        label.font = .setVerdanaBold(withSize: 18)
        label.textColor = .label
        label.textAlignment = .right
        return label
    }()

    private lazy var orderButton: UIButton = {
        let button = DefaultButton(text: "Заказать")
        button.addTarget(self, action: #selector(orderButtonPressed), for: .touchUpInside)
        return button
    }()

    // MARK: - Private Properties

    private var model: OrderStorageService?

    private var products: [Coffee] = [
        Coffee(type: "Американо", imageName: "americano", price: 100),
        Coffee(type: "Капучино", imageName: "cappuccino", price: 150),
        Coffee(type: "Латте", imageName: "latte", price: 200)
    ]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupUI()
        setupNavigationBar()

        getData()
    }

    // MARK: - Private Methods

    private func setupHierarchy() {
        [
            topView,
            typeProductSegmented,
            modificationLabel,
            roastingButton,
            extraOptionsButton,
            priceLabel,
            orderButton
        ].forEach { view.addSubview($0) }

        topView.addSubview(productImage)
    }

    private func setupUI() {
        view.backgroundColor = .white

        topView.frame = .init(x: 0, y: 0, width: 375, height: 346)
        typeProductSegmented.frame = .init(x: 15, y: 368, width: 345, height: 44)
        modificationLabel.frame = .init(x: 15, y: 432, width: 200, height: 30)
        roastingButton.frame = .init(x: 15, y: 482, width: 165, height: 165)
        extraOptionsButton.frame = .init(x: 195, y: 482, width: 165, height: 165)
        priceLabel.frame = .init(x: 15, y: 669, width: 345, height: 30)
        orderButton.frame = .init(x: 15, y: 717, width: 345, height: 53)
        productImage.frame = .init(x: 112, y: 128, width: 150, height: 150)
    }

    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButtonBar)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButtonBar)
    }

    private func getData() {
        model = OrderStorageService(
            product: products[0],
            roasting: .high
        )
    }

    private func updateRoasting() {
        guard let model else { return }
        roastingButton.configureView(typeRoasting: model.roasting)
    }

    private func updateStateButtons() {
        guard let model else { return }
        if model.additions.filter(\.select).count > .zero {
            extraOptionsButton.changeImage(imageName: "check")
        } else {
            extraOptionsButton.changeImage(imageName: "plus")
        }
    }

    private func updatePrice() {
        guard let model else { return }
        priceLabel.text = "Цѣна - \(model.price) руб"
    }

    private func goToSelectRoastingScreen() {
        let roastingViewController = CoffeeRoastingViewController()
        roastingViewController.currentRoasting = model?.roasting
        roastingViewController.didSelectRoasting = { [weak self] roastingType in
            self?.model?.changeRoasting(roastingType: roastingType)
            self?.updateRoasting()
        }
        roastingViewController.modalPresentationStyle = .formSheet
        if let sheet = roastingViewController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        present(roastingViewController, animated: true)
    }

    private func goToExtraOptionsScreen() {
        guard let model else { return }
        let extraOptionsViewController = ExtraOptionsViewController()
        extraOptionsViewController.setAdditions(additions: model.additions)
        extraOptionsViewController.didClosedExtraOptionsScreen = { [weak self] additions in
            self?.model?.changeOptions(options: additions)
            self?.updatePrice()
            self?.updateStateButtons()
        }
        extraOptionsViewController.modalPresentationStyle = .formSheet
        if let sheet = extraOptionsViewController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        present(extraOptionsViewController, animated: true)
    }

    private func goToBillScreen() {
        guard let model else { return }
        let billViewController = BillViewController()
//        billViewController.configureOrder(order: OrderStorageService)
        billViewController.modalPresentationStyle = .pageSheet
        present(billViewController, animated: true)
    }

    @objc private func productChanged(sender: UISegmentedControl) {
        if sender == typeProductSegmented {
            let segmentedIndex = sender.selectedSegmentIndex
            productImage.image = UIImage(named: products[segmentedIndex].imageName)
            model?.changeProduct(product: products[segmentedIndex])
            updatePrice()
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

    @objc private func roastingPressed(sender: UIView) {
        goToSelectRoastingScreen()
    }

    @objc private func extraOptionsPressed(sender: UIView) {
        goToExtraOptionsScreen()
    }

    @objc private func orderButtonPressed(sender: UIView) {
        goToBillScreen()
    }
}

extension ProductOptionsViewController: BillViewControllerProtocol {
    func didClosedScreen() {
        navigationController?.popToRootViewController(animated: true)
    }
}
