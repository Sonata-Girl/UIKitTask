// CoffeeRoastingViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран выбора способа обжарки для кофе
final class CoffeeRoastingViewController: UIViewController {
    // MARK: - Visual Components

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .label
        button.addTarget(nil, action: #selector(closeButtonPressed), for: .touchUpInside)
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Уточните обжарку зеренъ"
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

    var didSelectRoasting: ((RoastingType) -> ())?
    var currentRoasting: RoastingType?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupUI()

        setStatesCells()
    }

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

    // MARK: - Private Methods

    private func changeStateCell(sender: UIView, isSelected: Bool) {
        if isSelected {
            sender.layer.borderWidth = 1
        } else {
            sender.layer.borderWidth = 0
        }
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

    @objc private func closeButtonPressed() {
        guard let currentRoasting else { return }
        didSelectRoasting?(currentRoasting)
        dismiss(animated: true)
    }

    @objc private func roastingSelected(sender: UIView) {
        if sender == roastingHighButton {
            currentRoasting = .high
        } else {
            currentRoasting = .light
        }
        setStatesCells()
    }
}
