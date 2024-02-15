// CatalogViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Стартовый экран с каталогом одежды
final class CatalogViewController: UIViewController {
    
    // MARK: - Constants

    enum Constants {
        static let catalogLabelTitle = "Каталог"
        static let cameraImageTitle = "camera"
        static let barcodeImageTitle = "barcode.viewfinder"
        static let newImageViewLabelTitle = "Новинки"
        static let saleImageViewLabelTitle = "Распродажа"
        static let brendsViewLabelTitle = "Бренды"
        static let shoesViewLabelTitle = "Обувь"
        static let bagsViewLabelTitle = "Сумки"
        static let brendsImageViewTitle = "brends"
    }
    
// MARK: - Private Properties
    private var clothes: [Clothes] = [
        Clothes(
            type: "Женщинам",
            newImage: "woman_news",
            saleImage: "woman_sales",
            shoesImage: "shoes_woman",
            bagImage: "bag_woman"
        ),
        Clothes(
            type: "Мужчинам",
            newImage: "man_news",
            saleImage: "man_sales",
            shoesImage: "shoes_man",
            bagImage: "bag_man"
        ),
        Clothes(
            type: "Детям",
            newImage: "new_child",
            saleImage: "sale_child",
            shoesImage: "shoes_child",
            bagImage: "bag_child"
        )
    ]

    private let catalogLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.catalogLabelTitle
        label.font = .setVerdanaBold(withSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let cameraView: UIView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let cameraImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: Constants.cameraImageTitle)
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let barcodeView: UIView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let barcodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: Constants.barcodeImageTitle)
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var typeClotherSegmented: UISegmentedControl = {
        let segmented = UISegmentedControl(items: clothes.map(\.type))
        segmented.selectedSegmentIndex = 1
        segmented.backgroundColor = .systemGray6
        segmented.translatesAutoresizingMaskIntoConstraints = false
        segmented.addTarget(self, action: #selector(clotherChanged), for: .valueChanged)
        return segmented
    }()

    private let newImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray6
        imageView.layer.shadowColor = .init(red: 0, green: 0, blue: 0, alpha: 0.6)
        imageView.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        imageView.layer.shadowOpacity = 0.3
        imageView.layer.shadowRadius = 1.0
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let newImageViewLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.newImageViewLabelTitle
        label.font = .setVerdanaBold(withSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let saleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray6
        imageView.layer.shadowColor = .init(red: 0, green: 0, blue: 0, alpha: 0.6)
        imageView.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        imageView.layer.shadowOpacity = 0.3
        imageView.layer.shadowRadius = 1.0
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let saleImageViewLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.saleImageViewLabelTitle
        label.font = .setVerdanaBold(withSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let brendsView: UIView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(red: 248 / 255, green: 248 / 255, blue: 248 / 255, alpha: 1)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let brendsViewLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.brendsViewLabelTitle
        label.font = .setVerdanaBold(withSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let brendsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.brendsImageViewTitle)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var shoesView: UIView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(red: 248 / 255, green: 248 / 255, blue: 248 / 255, alpha: 1)
        view.layer.cornerRadius = 12
        let gesture = UITapGestureRecognizer(target: self, action: #selector(shoesViewTapped(_:)))
        view.addGestureRecognizer(gesture)
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let shoesViewLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.shoesViewLabelTitle
        label.font = .setVerdanaBold(withSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let shoesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let bagsView: UIView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(red: 248 / 255, green: 248 / 255, blue: 248 / 255, alpha: 1)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let bagsViewLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.bagsViewLabelTitle
        label.font = .setVerdanaBold(withSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let bagsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setConstraints()
        clotherChanged(sender: typeClotherSegmented)
    }
    
    // MARK: - Private methods
    
    private func setupHierarchy() {
        view.addSubview(catalogLabel)
        view.addSubview(cameraView)
        cameraView.addSubview(cameraImageView)
        view.addSubview(barcodeView)
        barcodeView.addSubview(barcodeImageView)
        view.addSubview(typeClotherSegmented)
        view.addSubview(newImageView)
        newImageView.addSubview(newImageViewLabel)
        view.addSubview(saleImageView)
        saleImageView.addSubview(saleImageViewLabel)
        view.addSubview(brendsView)
        brendsView.addSubview(brendsViewLabel)
        brendsView.addSubview(brendsImageView)
        view.addSubview(shoesView)
        shoesView.addSubview(shoesViewLabel)
        shoesView.addSubview(shoesImageView)
        view.addSubview(bagsView)
        bagsView.addSubview(bagsViewLabel)
        bagsView.addSubview(bagsImageView)
    }

    @objc private func clotherChanged(sender: UISegmentedControl) {
        if sender == typeClotherSegmented {
            let segmentedIndex = sender.selectedSegmentIndex
            newImageView.image = UIImage(named: clothes[segmentedIndex].newImage)
            saleImageView.image = UIImage(named: clothes[segmentedIndex].saleImage)
            shoesImageView.image = UIImage(named: clothes[segmentedIndex].shoesImage)
            bagsImageView.image = UIImage(named: clothes[segmentedIndex].bagImage)
        }
    }

    @objc private func shoesViewTapped(_ gesture: UITapGestureRecognizer) {
        navigationController?.pushViewController(ShoesViewController(), animated: true)
    }
}

// MARK: - Extensions

extension CatalogViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            catalogLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            catalogLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 9),

            cameraView.centerYAnchor.constraint(equalTo: catalogLabel.centerYAnchor),
            cameraView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60),
            cameraView.heightAnchor.constraint(equalToConstant: 40),
            cameraView.widthAnchor.constraint(equalToConstant: 40),

            cameraImageView.centerYAnchor.constraint(equalTo: cameraView.centerYAnchor),
            cameraImageView.centerXAnchor.constraint(equalTo: cameraView.centerXAnchor),

            barcodeView.centerYAnchor.constraint(equalTo: catalogLabel.centerYAnchor),
            barcodeView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            barcodeView.heightAnchor.constraint(equalToConstant: 40),
            barcodeView.widthAnchor.constraint(equalToConstant: 40),

            barcodeImageView.centerYAnchor.constraint(equalTo: barcodeView.centerYAnchor),
            barcodeImageView.centerXAnchor.constraint(equalTo: barcodeView.centerXAnchor),

            typeClotherSegmented.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 78),
            typeClotherSegmented.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            typeClotherSegmented.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),

            newImageView.topAnchor.constraint(equalTo: typeClotherSegmented.bottomAnchor, constant: 20),
            newImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            newImageView.heightAnchor.constraint(equalToConstant: 120),
            newImageView.widthAnchor.constraint(equalToConstant: 160),

            newImageViewLabel.topAnchor.constraint(equalTo: newImageView.topAnchor, constant: 0),
            newImageViewLabel.centerXAnchor.constraint(equalTo: newImageView.centerXAnchor),

            saleImageView.topAnchor.constraint(equalTo: typeClotherSegmented.bottomAnchor, constant: 20),
            saleImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saleImageView.heightAnchor.constraint(equalToConstant: 120),
            saleImageView.widthAnchor.constraint(equalToConstant: 160),

            saleImageViewLabel.bottomAnchor.constraint(equalTo: saleImageView.bottomAnchor, constant: 0),
            saleImageViewLabel.centerXAnchor.constraint(equalTo: saleImageView.centerXAnchor),

            brendsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            brendsView.topAnchor.constraint(equalTo: newImageView.bottomAnchor, constant: 20),
            brendsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            brendsView.heightAnchor.constraint(equalToConstant: 80),
            brendsView.widthAnchor.constraint(equalToConstant: 335),

            brendsViewLabel.leadingAnchor.constraint(equalTo: brendsView.leadingAnchor, constant: 20),
            brendsViewLabel.centerYAnchor.constraint(equalTo: brendsView.centerYAnchor),

            brendsImageView.trailingAnchor.constraint(equalTo: brendsView.trailingAnchor, constant: 0),
            brendsImageView.heightAnchor.constraint(equalToConstant: 80),
            brendsImageView.widthAnchor.constraint(equalToConstant: 99),
            brendsImageView.leadingAnchor.constraint(equalTo: brendsView.leadingAnchor, constant: 236),

            shoesView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            shoesView.topAnchor.constraint(equalTo: brendsView.bottomAnchor, constant: 20),
            shoesView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            shoesView.heightAnchor.constraint(equalToConstant: 80),
            shoesView.widthAnchor.constraint(equalToConstant: 99),

            shoesViewLabel.leadingAnchor.constraint(equalTo: shoesView.leadingAnchor, constant: 20),
            shoesViewLabel.centerYAnchor.constraint(equalTo: shoesView.centerYAnchor),

            shoesImageView.trailingAnchor.constraint(equalTo: shoesView.trailingAnchor, constant: 0),
            shoesImageView.heightAnchor.constraint(equalToConstant: 80),
            shoesImageView.widthAnchor.constraint(equalToConstant: 99),
            shoesImageView.leadingAnchor.constraint(equalTo: shoesView.leadingAnchor, constant: 236),

            bagsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bagsView.topAnchor.constraint(equalTo: shoesView.bottomAnchor, constant: 20),
            bagsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bagsView.heightAnchor.constraint(equalToConstant: 80),
            bagsView.widthAnchor.constraint(equalToConstant: 99),

            bagsViewLabel.leadingAnchor.constraint(equalTo: bagsView.leadingAnchor, constant: 20),
            bagsViewLabel.centerYAnchor.constraint(equalTo: bagsView.centerYAnchor),

            bagsImageView.trailingAnchor.constraint(equalTo: bagsView.trailingAnchor, constant: 0),
            bagsImageView.heightAnchor.constraint(equalToConstant: 80),
            bagsImageView.widthAnchor.constraint(equalToConstant: 99),
            bagsImageView.leadingAnchor.constraint(equalTo: bagsView.leadingAnchor, constant: 236),
        ])
    }
}
