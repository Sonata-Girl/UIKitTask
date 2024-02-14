// ExtraOptionsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран выбора дополнительных ингредиентов для продукта
final class ExtraOptionsViewController: UIViewController {
    // MARK: Constants

    private enum Constants {
        static let titleExtraOptionsScreen = "Выберите дополнительные \nингредіенты"
        static let currencyName = "руб"
        static let sideInset: CGFloat = 20
        static let labelsWidth: CGFloat = 54
        static let verticalInset: CGFloat = 15
    }

    // MARK: - Visual Components

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .label
        button.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.titleExtraOptionsScreen
        label.font = .setVerdanaBold(withSize: 18)
        label.numberOfLines = 2
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()

    private var components: [UISwitch] = []

    // MARK: - Public Properties

    var closeExtraOptionsScreenHandler: (([ExtraOption]) -> ())?

    // MARK: - Private Properties

    private var additions: [ExtraOption] = []

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupUI()
    }

    // MARK: - Public methods

    func setAdditions(additions: [ExtraOption]) {
        self.additions = additions
    }

    // MARK: - Private Methods

    private func setupHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
    }

    private func setupUI() {
        view.backgroundColor = .white

        closeButton.frame = .init(x: 20, y: 26, width: 14, height: 14)
        titleLabel.frame = .init(x: 40, y: 53, width: 294, height: 44)

        var currentLineY: CGFloat = 124
        let offsetLeftRight: CGFloat = 20
        let height: CGFloat = 35
        for addition in additions {
            let labelName = UILabel()
            labelName.font = .setVerdana(withSize: 18)
            labelName.numberOfLines = 2
            let myRange = NSRange(
                location: addition.name.count + 1,
                length: "+\(addition.price) \(Constants.currencyName)".count
            )
            let attributedString =
                NSMutableAttributedString(string: "\(addition.name) +\(addition.price) \(Constants.currencyName)")
            attributedString.addAttribute(
                NSAttributedString.Key.foregroundColor,
                value: UIColor.systemGreen, range: myRange
            )
            labelName.attributedText = attributedString
            labelName.frame = .init(x: offsetLeftRight, y: currentLineY, width: 275, height: height)

            let switcher = UISwitch()
            switcher.isOn = addition.select
            switcher.frame = .init(
                x: view.frame.width - Constants.sideInset - Constants.labelsWidth,
                y: currentLineY,
                width: Constants.labelsWidth, height: height
            )
            switcher.addTarget(self, action: #selector(switcherValueChanged), for: .valueChanged)
            view.addSubview(labelName)
            view.addSubview(switcher)
            components.append(switcher)

            currentLineY += height + Constants.verticalInset
        }
    }

    @objc private func closeButtonPressed() {
        closeExtraOptionsScreenHandler?(additions)
        dismiss(animated: true)
    }

    @objc private func switcherValueChanged(sender: UISwitch) {
        if let indexOption = components.firstIndex(of: sender) {
            additions[indexOption].select = sender.isOn
        }
    }
}
