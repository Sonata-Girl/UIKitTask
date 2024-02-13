// BillViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol BillViewControllerProtocol: AnyObject {
    func didClosedScreen()
}
/// Экран для показа итоговой суммы продукта и перехода для оплаты
final class BillViewController: UIViewController {

    // MARK: - Visual Components

    private let whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "x"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()

    private let leftBranchImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "left branch")
        return imageView
    }()

    private let rightBranchImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "right branch")
        return imageView
    }()

    private let orderLabel: UILabel = {
        let label = UILabel()
        label.font = .setVerdanaBold(withSize: 18)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Вашъ Заказъ"
        return label
    }()

    private let americanoLabel: UILabel = {
        let label = UILabel()
        label.font = .setVerdanaBold(withSize: 16)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Американо"
        return label
    }()

    private let americanoPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .setVerdanaBold(withSize: 16)
        label.textColor = .black
        label.textAlignment = .right
        label.text = "100 руб"
        return label
    }()

    private let milkLabel: UILabel = {
        let label = UILabel()
        label.font = .setVerdana(withSize: 16)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Молоко"
        return label
    }()

    private let milkPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .setVerdana(withSize: 16)
        label.textColor = .black
        label.textAlignment = .right
        label.text = "50 руб"
        return label
    }()

    private let espressoLabel: UILabel = {
        let label = UILabel()
        label.font = .setVerdana(withSize: 16)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Эспрессо 50мл"
        return label
    }()

    private let espressoPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .setVerdana(withSize: 16)
        label.textColor = .black
        label.textAlignment = .right
        label.text = "50 руб"
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .setVerdanaBold(withSize: 18)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Цъна - 200 руб"
        return label
    }()

    private let flowerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "flower")
        return imageView
    }()

    private lazy var payButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 89 / 255, green: 190 / 255, blue: 199 / 255, alpha: 1)
        button.setTitle("Оплатить", for: .normal)
        button.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
        button.tintColor = .white
        button.titleLabel?.font = .setVerdanaBold(withSize: 18)
        button.layer.cornerRadius = 12
        return button
    }()
    
    // MARK: - Public Properties
    
    weak var delegate: (BillViewControllerProtocol)?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupUI()
    }

    // MARK: - Private Methods
    
    private func setupHierarchy() {
        view.addSubview(whiteView)
        whiteView.addSubview(closeButton)
        whiteView.addSubview(leftBranchImage)
        whiteView.addSubview(rightBranchImage)
        whiteView.addSubview(orderLabel)
        whiteView.addSubview(americanoLabel)
        whiteView.addSubview(americanoPriceLabel)
        whiteView.addSubview(milkLabel)
        whiteView.addSubview(milkPriceLabel)
        whiteView.addSubview(espressoLabel)
        whiteView.addSubview(espressoPriceLabel)
        whiteView.addSubview(priceLabel)
        whiteView.addSubview(flowerImage)
        whiteView.addSubview(payButton)
    }

    private func setupUI() {
        view.backgroundColor = UIColor(red: 240 / 255, green: 224 / 255, blue: 208 / 255, alpha: 1)
        whiteView.frame = .init(x: 0, y: 66, width: 375, height: 746)
        closeButton.frame = .init(x: 20, y: 26, width: 14, height: 14)
        leftBranchImage.frame = .init(x: 20, y: 47.29, width: 100, height: 72.71)
        rightBranchImage.frame = .init(x: 260, y: 47.29, width: 100, height: 72.21)
        orderLabel.frame = .init(x: 120, y: 100, width: 140, height: 30)
        americanoLabel.frame = .init(x: 20, y: 155, width: 150, height: 30)
        americanoPriceLabel.frame = .init(x: 225, y: 155, width: 130, height: 30)
        milkLabel.frame = .init(x: 20, y: 191, width: 150, height: 30)
        milkPriceLabel.frame = .init(x: 225, y: 191, width: 130, height: 30)
        espressoLabel.frame = .init(x: 20, y: 227, width: 150, height: 30)
        espressoPriceLabel.frame = .init(x: 225, y: 227, width: 130, height: 30)
        priceLabel.frame = .init(x: 72, y: 433, width: 231, height: 30)
        flowerImage.frame = .init(x: 137.5, y: 472, width: 100, height: 40)
        payButton.frame = .init(x: 15, y: 632, width: 345, height: 53)
    }

    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func payButtonTapped() {
        let finishedViewController = FinishedOrderViewController()
        finishedViewController.modalPresentationStyle = .fullScreen
        present(finishedViewController, animated: true)
    }
}

// MARK: - Extensions

extension BillViewController: FinishOrderProtocol {
    func didClosedScreen() {
        delegate?.didClosedScreen()
        dismiss(animated: true)
    }
}
