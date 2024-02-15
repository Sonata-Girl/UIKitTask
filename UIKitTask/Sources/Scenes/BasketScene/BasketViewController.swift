// BasketViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран корзины для товаров
class BasketViewController: UIViewController {
    // MARK: - Types

    private enum Constants {
        static let screenTitle = "Корзина"

        static let orderButtonTitle = "Оформить заказ - 4250 ₽"
        static let backButtonImage = UIImage(systemName: "chevron.left")
    }

    // MARK: - Constants

    // MARK: - IBOutlet

    // MARK: - Visual Components

    private lazy var orderDataButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .appPink
        button.setTitle(Constants.orderButtonTitle, for: .normal)
        button.titleLabel?.font = .setVerdanaBold(withSize: 16)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowOpacity = 0.5
        button.layer.cornerRadius = 10
        button.isHidden = true
//        button.addTarget(self, action: #selector(saveData), for: .touchUpInside)
        return button
    }()

    private let cellGoodView: BasketCellView = {
        let view = BasketCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Public Properties

    // MARK: - Private Properties

    // MARK: - Initializers

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setupHierarchy()
        setupUI()
        setupHandle()
    }

    // MARK: - Public methods

    // MARK: - IBAction или @objc (not private)

    // MARK: - Private Methods

    private func configureNavigationBar() {
        navigationItem.title = Constants.screenTitle
    }

    private func setupHierarchy() {
        [
            cellGoodView,
            orderDataButton
        ].forEach { view.addSubview($0) }
    }

    private func setupUI() {

        NSLayoutConstraint.activate([
            cellGoodView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            cellGoodView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: cellGoodView.trailingAnchor),
            cellGoodView.heightAnchor.constraint(equalToConstant: 157),
            cellGoodView.widthAnchor.constraint(equalToConstant: view.bounds.width)
        ])

        NSLayoutConstraint.activate([
            orderDataButton.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 20
            ),

            view.safeAreaLayoutGuide.trailingAnchor.constraint(
                equalTo: orderDataButton.trailingAnchor,
                constant: 20
            ),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(
                equalTo: orderDataButton.bottomAnchor,
                constant: 20
            ),
            orderDataButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func setupHandle() {
        cellGoodView.goodDeletedHandle = { (_,_) in
            self.cellGoodView.removeFromSuperview()
        }
    }
}
