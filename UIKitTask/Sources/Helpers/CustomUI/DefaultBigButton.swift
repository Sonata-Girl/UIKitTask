// DefaultBigButton.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Кастомная квадратная с угловым радиусом кнопка для отображения картинки и снизу описания
final class DefaultBigButton: UIButton {
    // MARK: Visual Components

    private let image: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private let title: UILabel = {
        let label = UILabel()
        label.font = .setVerdana(withSize: 14)
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    // MARK: Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitle("", for: .normal)

        setupHierarchy()
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHierarchy()
        setupUI()
    }

    // MARK: Public methods

    func configureView(typeRoasting: RoastingType) {
        image.image = typeRoasting.image
        title.text = typeRoasting.title
        image.frame = .init(x: 31, y: 17, width: 100, height: 100)
    }

    func configureView(title: String, imageName: String) {
        image.image = UIImage(named: imageName)
        self.title.text = title
        image.frame = .init(x: 67, y: 56, width: 29, height: 29)
    }

    func changeImage(imageName: String) {
        image.image = UIImage(named: imageName)
    }

    // MARK: Private methods

    private func setupHierarchy() {
        [
            image,
            title
        ].forEach { addSubview($0) }
    }

    private func setupUI() {
        backgroundColor = .systemGray6
        layer.cornerRadius = 20

        title.frame = .init(x: 0, y: 117, width: 165, height: 37)
    }
}
