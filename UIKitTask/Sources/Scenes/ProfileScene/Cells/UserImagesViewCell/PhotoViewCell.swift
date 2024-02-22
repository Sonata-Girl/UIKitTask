// PhotoViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка для отображения фотографии
final class PhotoViewCell: UICollectionViewCell {
    // MARK: Constants

    private enum Constants {
        static let thirdWidthScreen: CGFloat = 3
        static let doubleInsetWidthScreen: CGFloat = 1.5 * 2
    }

    static var identifier: String {
        String(describing: self)
    }

    // MARK: Visual Components

    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    // MARK: Initializers

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

    override func layoutSubviews() {
        super.layoutSubviews()
        setupContentViewConstraints()
    }

    // MARK: Public methods

    func configureCell(photoName: String) {
        mainImageView.image = UIImage(named: photoName)
    }

    // MARK: Private Methods

    private func setupHierarchy() {
        contentView.addSubview(mainImageView)
    }

    private func setupConstraints() {
        setupContentViewConstraints()
        setupMainImageViewConstraint()
    }

    private func setupContentViewConstraints() {
        for constraint in contentView.constraints {
            if constraint.firstAttribute == .width || constraint.firstAttribute == .height {
                contentView.removeConstraint(constraint)
            }
        }

        let screenWidth = UIScreen.main.bounds.width
        contentView.heightAnchor.constraint(
            equalToConstant: (min(screenWidth, UIScreen.main.bounds.height) - Constants.doubleInsetWidthScreen) /
                Constants.thirdWidthScreen
        ).isActive = true
        contentView.widthAnchor.constraint(
            equalToConstant: (screenWidth - Constants.doubleInsetWidthScreen) / Constants.thirdWidthScreen
        ).isActive = true
    }

    private func setupMainImageViewConstraint() {
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
