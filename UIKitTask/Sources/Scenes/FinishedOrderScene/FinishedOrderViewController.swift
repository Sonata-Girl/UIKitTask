// FinishedOrderViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для закрытия предыдущего экрана
protocol FinishOrderProtocol: AnyObject {
    /// Функция для закрытия предыдущего экрана
    func didClosedScreen()
}

/// Экран отображения благодарности за заказ и просьба об отзыве, окончание процесса заказа и оплаты
final class FinishedOrderViewController: UIViewController {
    // MARK: Private Properties

    private enum Constants {
        static let closeButtonTitle = "x"
        static let branchesImageTitle = "branches"
        static let thanksImageTitle = "thanks"
        static let promoLabelTitle = """
        Разскажи о насъ другу, отправь ему промокодъ на безплатный напитокъ и получи скидку 10% на слъдующiй заказъ.
        """
    }

    // MARK: - Visual Components

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.closeButtonTitle), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()

    private let branchesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: Constants.branchesImageTitle)
        return imageView
    }()

    private let thanksImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: Constants.thanksImageTitle)
        return imageView
    }()

    private let promoLabel: UILabel = {
        let label = UILabel()
        label.font = .setVerdana(withSize: 16)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = Constants.promoLabelTitle
        return label
    }()

    private lazy var okButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 89 / 255, green: 190 / 255, blue: 199 / 255, alpha: 1)
        button.setTitle("Хорошо", for: .normal)
        button.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        button.tintColor = .white
        button.titleLabel?.font = .setVerdanaBold(withSize: 18)
        button.layer.cornerRadius = 12
        return button
    }()

    // MARK: - Public Properties

    weak var delegate: FinishOrderProtocol?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupUI()
    }

    // MARK: = Private Methods

    private func setupHierarchy() {
        view.addSubview(closeButton)
        view.addSubview(branchesImage)
        view.addSubview(thanksImage)
        view.addSubview(promoLabel)
        view.addSubview(okButton)
    }

    private func setupUI() {
        view.backgroundColor = .white
        closeButton.frame = .init(x: 20, y: 66, width: 14, height: 14)
        branchesImage.frame = .init(x: 92, y: 122, width: 200, height: 86.62)
        thanksImage.frame = .init(x: 75, y: 250, width: 235, height: 128)
        promoLabel.frame = .init(x: 30, y: 428, width: 315, height: 89)
        okButton.frame = .init(x: 20, y: 632, width: 345, height: 53)
    }

    private func closeWindow() {
        dismiss(animated: true)
    }

    @objc private func closeButtonTapped() {
        closeWindow()
    }

    @objc private func okButtonTapped() {
        delegate?.didClosedScreen()
        closeWindow()
    }
}
