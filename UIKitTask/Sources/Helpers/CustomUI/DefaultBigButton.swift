// DefaultBigButton.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class DefaultBigButton: UIButton {
    // MARK: - Visual Components

    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "highRoasting")
        return imageView
    }()

    private let title: UILabel = {
        let label = UILabel()
        label.text = "Темная \nобжарка"
        label.font = .setVerdana(withSize: 14)
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHierarchy()
        setupUI()
    }

    // MARK: - Public methods

    func configureView(typeRoasting: RoastingType) {
        image.image = typeRoasting.image
        title.text = typeRoasting.title
        setTitle("", for: .normal)
        image.frame = .init(x: 31, y: 17, width: 100, height: 100)
    }

    func configureView(title: String, imageName: String) {
        image.image = UIImage(named: imageName)
        self.title.text = title
        setTitle("", for: .normal)
        image.frame = .init(x: 67, y: 56, width: 29, height: 29)
    }

    func changeImage(imageName: String) {
        image.image = UIImage(named: imageName)
    }

    // MARK: - Private methods

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
