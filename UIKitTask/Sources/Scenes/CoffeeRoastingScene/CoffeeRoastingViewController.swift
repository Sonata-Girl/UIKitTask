// CoffeeRoastingViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Степени обжарки кофе
enum RoastingType {
    // Сильная степень обжарки
    case high
    // Слабая степень обжарки
    case light

    // Имя картинки для обжарок
    var image: UIImage {
        switch self {
        case .high:
            return .highRoasting
        case .light:
            return .lightRoasting
        }
    }

    // Наименование обжарки для кнопок
    var title: String {
        switch self {
        case .high:
            return "Темная \nобжарка"
        case .light:
            return "Свѣтлая \nобжарка"
        }
    }
}

/// Экран выбора способа обжарки для кофе
final class CoffeeRoastingViewController: UIViewController {
    // MARK: Constants

    private enum Constants {
        static let titleRoastingScreen = "Уточните обжарку зеренъ"
    }

    // MARK: Visual Components

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .label
        button.addTarget(self, action: #selector(sendSelectionAndCloseScreen), for: .touchUpInside)
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.titleRoastingScreen
        label.font = .setVerdanaBold(withSize: 18)
        label.textColor = .label
        return label
    }()

    private lazy var roastingHighButton: DefaultBigButton = {
        let button = DefaultBigButton()
        button.configureView(typeRoasting: .high)
        button.addTarget(self, action: #selector(roastingSelected), for: .touchUpInside)
        button.layer.borderColor = UIColor.appTurquoise.cgColor
        return button
    }()

    private lazy var roastingLightButton: DefaultBigButton = {
        let button = DefaultBigButton()
        button.configureView(typeRoasting: .light)
        button.addTarget(self, action: #selector(roastingSelected), for: .touchUpInside)
        button.layer.borderColor = UIColor.appTurquoise.cgColor
        return button
    }()

    // MARK: - Public Properties

    var selectedRoastingHandler: ((RoastingType) -> ())?
    var currentRoasting: RoastingType?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupUI()

        setStatesCells()
    }

    // MARK: - Private Methods

    private func setupHierarchy() {
        [
            closeButton,
            roastingHighButton,
            roastingLightButton
        ].forEach { view.addSubview($0) }
    }

    private func setupUI() {
        view.backgroundColor = .white

        closeButton.frame = .init(x: 20, y: 26, width: 14, height: 14)
        titleLabel.frame = .init(x: 40, y: 53, width: 294, height: 30)
        roastingHighButton.frame = .init(x: 15, y: 102, width: 165, height: 165)
        roastingLightButton.frame = .init(x: 195, y: 102, width: 165, height: 165)
    }

    private func changeStateCell(sender: UIView, isSelected: Bool) {
        sender.layer.borderWidth = isSelected ? 1 : 0
    }

    private func setStatesCells() {
        switch currentRoasting {
        case .high:
            changeStateCell(sender: roastingHighButton, isSelected: true)
            changeStateCell(sender: roastingLightButton, isSelected: false)
        case .light:
            changeStateCell(sender: roastingHighButton, isSelected: false)
            changeStateCell(sender: roastingLightButton, isSelected: true)
        default: break
        }
    }

    @objc private func sendSelectionAndCloseScreen() {
        guard let currentRoasting else { return }
        selectedRoastingHandler?(currentRoasting)
        dismiss(animated: true)
    }

    @objc private func roastingSelected(sender: UIView) {
        currentRoasting = sender == roastingHighButton ? .high : .light
        setStatesCells()
    }
}
