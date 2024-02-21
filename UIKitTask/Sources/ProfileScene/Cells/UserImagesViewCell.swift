// UserImagesViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка для показа фотографий пользователя
class UserImagesViewCell: UITableViewCell {
    // MARK: - Types

    // MARK: - Constants

    // MARK: - IBOutlet

    // MARK: - Visual Components

    private lazy var imageCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: setupCollectionLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(PhotoViewCell.self, forCellWithReuseIdentifier: PhotoViewCell.identifier)
        collection.dataSource = self
        return collection
    }()

    // MARK: - Public Properties

    // MARK: - Private Properties

    private let storageSource = StorageService()
    private var photos: [Photo] = []

    // MARK: - Initializers

    override func awakeFromNib() {
        super.awakeFromNib()
        fillSource()
        configureView()
        setupHierarchy()
        setupConstraints()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print("")
        // Configure the view for the selected state
    }

    // MARK: - Public methods

    // MARK: - IBAction или @objc (not private)

    // MARK: - Private Methods

    private func setupCollectionLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        // Размер ячеек
        flowLayout.itemSize = .init(width: 124, height: 124)
        // ячейки принимают размер самой ячейки (указанной в констрейнтах ячейки
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        // Расстояние между ячейками вертикальное
        flowLayout.minimumLineSpacing = 10
        // Расстояние между ячейками горизонтальное
        flowLayout.minimumInteritemSpacing = 10
        //  Отступы в секциях с каждой стороны экрана
        flowLayout.sectionInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        return flowLayout
    }

    private func configureView() {}

    private func setupHierarchy() {
        contentView.addSubview(imageCollectionView)
    }

    private func setupConstraints() {
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

    private func fillSource() {
        photos = storageSource.getMyImages()
    }

    // MARK: - IBAction или @objc (private)

    // MARK: - Configure Navigation bar

    // MARK: - Setup hierarchy

    // MARK: - Setup layouts for UIElements

    // MARK: - Configure view property

    // MARK: - CollectionViewDataSource

    // MARK: - CollectionViewDelegate

    // MARK: - Collection layout methods

    // MARK: - Constants
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
