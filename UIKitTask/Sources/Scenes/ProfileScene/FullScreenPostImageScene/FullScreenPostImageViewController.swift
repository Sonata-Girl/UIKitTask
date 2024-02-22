// FullScreenPostImageViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран для отображения картинки поста в полном размере
final class FullScreenPostImageViewController: UIViewController {
    // MARK: Visual Components

    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 13
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(.closeButton, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(closeScreen), for: .touchUpInside)
        return button
    }()

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierarchy()
        setupConstraints()
    }

    // MARK: Public methods

    func configureView(postImageName: String) {
        postImageView.image = UIImage(named: postImageName)
    }

    // MARK: Private Methods

    private func setupHierarchy() {
        view.addSubview(postImageView)
        postImageView.addSubview(closeButton)
    }

    private func setupConstraints() {
        setupPostImageViewViewConstraint()
        setupCloseButtonConstraint()
    }

    private func setupPostImageViewViewConstraint() {
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            postImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupCloseButtonConstraint() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: postImageView.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: postImageView.trailingAnchor, constant: -10),
            closeButton.heightAnchor.constraint(equalToConstant: 15),
            closeButton.widthAnchor.constraint(equalToConstant: 15),
        ])
    }

    @objc private func closeScreen() {
        dismiss(animated: true)
    }
}
