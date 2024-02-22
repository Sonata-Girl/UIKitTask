// UserImagesViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка для показа фотографий пользователя
final class UserImagesViewCell: UITableViewCell {
    // MARK: Constants

    static var identifier: String {
        String(describing: self)
    }

    // MARK: Visual Components

    private lazy var imageCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: setupCollectionLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(PhotoViewCell.self, forCellWithReuseIdentifier: PhotoViewCell.identifier)
        collection.dataSource = self
        return collection
    }()

    // MARK: Private Properties

    private var photos: [Photo] = []

    // MARK: Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHierarchy()
        setupConstraints()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        photos.removeAll()
    }

    // MARK: Public Methods

    func configureCell(photos: [Photo]) {
        self.photos = photos
    }

    // MARK: Private Methods

    private func setupCollectionLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        flowLayout.itemSize = .init(width: 124, height: 124)
        flowLayout.minimumLineSpacing = 1.5
        flowLayout.minimumInteritemSpacing = 1.5

        return flowLayout
    }

    private func setupHierarchy() {
        contentView.addSubview(imageCollectionView)
    }

    private func setupConstraints() {
        contentView.heightAnchor.constraint(equalToConstant: 124 * 5).isActive = true
        setupImageCollectionConstraint()
    }

    private func setupImageCollectionConstraint() {
        NSLayoutConstraint.activate([
            imageCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

/// UserImagesViewCell + UICollectionViewDataSource
extension UserImagesViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PhotoViewCell.identifier,
                for: indexPath
            ) as? PhotoViewCell
        else { return UICollectionViewCell() }
        cell.configureCell(photoName: photos[indexPath.item].imageName)
        return cell
    }
}
