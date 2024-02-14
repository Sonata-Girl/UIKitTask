// DefaultButton.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Кастомная кнопка для исключения дублирования создания кнопок
final class DefaultButton: UIButton {
    // MARK: Constants

    private enum Constants {
        static let radiusDivider: CGFloat = 4
    }

    // MARK: private Properties

    private var text: String = ""
    private var color: UIColor?

    // MARK: Initializers

    init(text: String, color: UIColor = .appTurquoise) {
        super.init(frame: .zero)
        self.text = text
        self.color = color

        setupButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }

    // MARK: Private Methods

    private func setupButton() {
        titleLabel?.textColor = .white
        setTitle(text, for: .normal)
        titleLabel?.font = .setVerdanaBold(withSize: 18)
        backgroundColor = color

        frame.size.width = 345
        frame.size.height = 53
        layer.cornerRadius = frame.size.height / Constants.radiusDivider
    }
}
