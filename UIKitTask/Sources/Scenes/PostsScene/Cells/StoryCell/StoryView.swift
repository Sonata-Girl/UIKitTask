// StoryView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Вью для отображения сторис
final class StoryView: UIView {
    // MARK: Constants

    private enum Constants {
        static let yourStories = "Ваша история"
    }

    // MARK: Visual Components

    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 30
        return imageView
    }()

    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .setVerdana(withSize: 8)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()

    private let plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.plusMini, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .appRed
        button.isHidden = true
        button.layer.cornerRadius = 10
        return button
    }()

    // MARK: Privates Properties

    private var viewLayers: [CALayer] = []
    private var story: Story?

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

    // MARK: Life Cycle

    override func layoutSubviews() {
        super.layoutSubviews()
        updateGradient()
    }

    // MARK: Public methods

    func configureView(storyModel: Story) {
        story = storyModel
        guard let story else { return }
        mainImageView.image = UIImage(named: story.user.avatarImage)
        userNameLabel.text = story.user.name
        if story.isYour {
            plusButton.isHidden = false
            userNameLabel.textColor = .gray
            userNameLabel.text = Constants.yourStories
        }
    }

    func updateGradient() {
        guard let story,
              !story.isYour
        else { return }
        addGradient(view: mainImageView)
    }

    // MARK: Private methods

    private func setupHierarchy() {
        [
            mainImageView,
            userNameLabel,
        ].forEach { addSubview($0) }

        addSubview(plusButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            mainImageView.heightAnchor.constraint(equalToConstant: 60),
            mainImageView.widthAnchor.constraint(equalToConstant: 60)
        ])

        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 5),
            userNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            userNameLabel.heightAnchor.constraint(equalToConstant: 7)
        ])

        NSLayoutConstraint.activate([
            plusButton.trailingAnchor.constraint(equalTo: mainImageView.trailingAnchor),
            plusButton.bottomAnchor.constraint(equalTo: mainImageView.bottomAnchor),
            plusButton.widthAnchor.constraint(equalToConstant: 20),
            plusButton.heightAnchor.constraint(equalToConstant: 20),
        ])
    }

    private func changeStoryToWatched(isWatched: Bool) {
        deleteGradient()
    }

    private func deleteGradient() {
        viewLayers.forEach { $0.removeFromSuperlayer() }
    }

    private func addGradient(view: UIView) {
        guard viewLayers.isEmpty else { return }
        let imageGradient = CAGradientLayer()
        imageGradient.colors = [UIColor.yellow.cgColor, UIColor.orange.cgColor, UIColor.red.cgColor]
        imageGradient.startPoint = CGPoint(x: 0, y: 1)
        imageGradient.endPoint = CGPoint(x: 1, y: 0)
        imageGradient.frame = view.frame.offsetBy(dx: -1, dy: -1)
        imageGradient.frame.size.width = view.bounds.width + 2
        imageGradient.frame.size.height = view.bounds.height + 2
        imageGradient.cornerRadius = imageGradient.frame.size.height / 2
        imageGradient.masksToBounds = true
        layer.insertSublayer(imageGradient, at: 0)
        viewLayers.append(imageGradient)
    }
}
