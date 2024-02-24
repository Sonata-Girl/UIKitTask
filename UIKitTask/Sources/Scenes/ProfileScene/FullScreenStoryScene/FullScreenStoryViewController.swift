// FullScreenStoryViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран для отображения сторис в полный экран
final class FullScreenStoryViewController: UIViewController {
    // MARK: Visual Components

    private let storyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 13
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()

    private let storyProgressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressViewStyle = .bar
        progressView.trackTintColor = .gray
        progressView.progressTintColor = .white
        progressView.setProgress(0, animated: true)
        progressView.layer.cornerRadius = 1
        return progressView
    }()

    private let fullSizeStoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    private let storyDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .setVerdana(withSize: 10)
        label.textColor = .white
        return label
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(.closeButton, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(closeScreen), for: .touchUpInside)
        return button
    }()

    // MARK: Private Properties

    private var myStory: MyStory?
    private var timer = Timer()

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierarchy()
        setupConstraints()
    }

    // MARK: Public methods

    func configureView(myStory: MyStory) {
        self.myStory = myStory
        fullSizeStoryImageView.image = UIImage(named: myStory.imageName)
        storyImageView.image = UIImage(named: myStory.imageName)
        storyDescriptionLabel.text = myStory.description
        setupTimer()
    }

    // MARK: Private Methods

    private func setupHierarchy() {
        view.addSubview(fullSizeStoryImageView)
        [
            storyProgressView,
            storyImageView,
            storyDescriptionLabel,
            closeButton
        ].forEach { fullSizeStoryImageView.addSubview($0) }
    }

    private func setupConstraints() {
        setupFullSizeStoryImageViewConstraint()
        setupStoryProgressViewConstraint()
        setupStoryImageViewConstraint()
        setupStoryDescriptionLabelConstraint()
        setupCloseButtonConstraint()
    }

    private func setupFullSizeStoryImageViewConstraint() {
        NSLayoutConstraint.activate([
            fullSizeStoryImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            fullSizeStoryImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            fullSizeStoryImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            fullSizeStoryImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupStoryProgressViewConstraint() {
        NSLayoutConstraint.activate([
            storyProgressView.topAnchor.constraint(equalTo: fullSizeStoryImageView.topAnchor, constant: 11),
            storyProgressView.leadingAnchor.constraint(equalTo: fullSizeStoryImageView.leadingAnchor, constant: 5),
            storyProgressView.trailingAnchor.constraint(equalTo: fullSizeStoryImageView.trailingAnchor, constant: -5),
            storyProgressView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }

    private func setupStoryImageViewConstraint() {
        NSLayoutConstraint.activate([
            storyImageView.topAnchor.constraint(equalTo: storyProgressView.topAnchor, constant: 10),
            storyImageView.leadingAnchor.constraint(equalTo: fullSizeStoryImageView.leadingAnchor, constant: 5),
            storyImageView.heightAnchor.constraint(equalToConstant: 26),
            storyImageView.widthAnchor.constraint(equalToConstant: 26),
        ])
    }

    private func setupStoryDescriptionLabelConstraint() {
        NSLayoutConstraint.activate([
            storyDescriptionLabel.topAnchor.constraint(equalTo: storyProgressView.topAnchor, constant: 10),
            storyDescriptionLabel.leadingAnchor.constraint(equalTo: storyImageView.trailingAnchor, constant: 5),
            storyDescriptionLabel.heightAnchor.constraint(equalToConstant: 15),
            storyDescriptionLabel.widthAnchor.constraint(equalToConstant: 60),
        ])
    }

    private func setupCloseButtonConstraint() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: storyProgressView.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: fullSizeStoryImageView.trailingAnchor, constant: -10),
            closeButton.heightAnchor.constraint(equalToConstant: 15),
            closeButton.widthAnchor.constraint(equalToConstant: 15),
        ])
    }

    private func setupTimer() {
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(updateProgressBar),
            userInfo: nil,
            repeats: true
        )
    }

    @objc private func updateProgressBar() {
        if storyProgressView.progress != 1.0 {
            storyProgressView.progress += 0.1 / 1.0
        } else if storyProgressView.progress == 1.0 {
            UIView.animate(withDuration: 0.7) { [weak self] in
                self?.timer.invalidate()
                self?.dismiss(animated: true)
            }
        }
    }

    @objc private func closeScreen() {
        dismiss(animated: true)
    }
}
