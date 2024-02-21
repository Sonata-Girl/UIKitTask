// PhotoViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка для отображения фотографии
final class PhotoViewCell: UICollectionViewCell {
    // MARK: - Constants

    static var identifier: String {
        String(describing: self)
    }

    // MARK: - Visual Components

    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    // MARK: - Private Properties

    private let storageSource = StorageService()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHierarchy()
        setupConstraints()
    }

    // MARK: - Public methods

    func configureCell(photoName: String) {
        mainImageView.image = UIImage(named: photoName)
    }

    // MARK: - Private Methods

    private func setupHierarchy() {
        contentView.addSubview(mainImageView)
    }

    private func setupConstraints() {
        setupMainImageViewConstraint()
    }

    private func setupMainImageViewConstraint() {
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
