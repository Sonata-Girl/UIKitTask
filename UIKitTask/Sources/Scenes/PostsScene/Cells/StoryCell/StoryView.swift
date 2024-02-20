// StoryView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка для отображения сторис
final class StoryView: UIView {
    // MARK: Constants

    private enum Constants {
        static let yourStories = "Ваша история"
    }

    // MARK: Visual Components

    private let mainImage: UIImageView = {
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

    private var layersInView: [CALayer] = []
    private var model: Story?
    private let imageGradient = CAGradientLayer()

    // MARK: Initializers

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

    // MARK: Public methods

    func configureView(storyModel: Story) {
        model = storyModel
        guard let model else { return }
        mainImage.image = UIImage(named: model.user.avatarImage)
        userNameLabel.text = model.user.name
        if model.isYour {
            plusButton.isHidden = false
            userNameLabel.textColor = .gray
            userNameLabel.text = Constants.yourStories
        }
    }

    func updateGradient() {
        guard let model,
              !model.isYour
        else { return }
        addGradient(view: mainImage)
    }

    // MARK: Private methods

    override func layoutSubviews() {
        super.layoutSubviews()
        updateGradient()
    }

    private func setupHierarchy() {
        [
            mainImage,
            userNameLabel,
        ].forEach { addSubview($0) }

        addSubview(plusButton)
    }

    private func setupUI() {
        backgroundColor = .white

        NSLayoutConstraint.activate([
            mainImage.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            mainImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            mainImage.heightAnchor.constraint(equalToConstant: 60),
            mainImage.widthAnchor.constraint(equalToConstant: 60)
        ])

        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 5),
            userNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            userNameLabel.heightAnchor.constraint(equalToConstant: 7)
        ])

        NSLayoutConstraint.activate([
            plusButton.trailingAnchor.constraint(equalTo: mainImage.trailingAnchor),
            plusButton.bottomAnchor.constraint(equalTo: mainImage.bottomAnchor),
            plusButton.widthAnchor.constraint(equalToConstant: 20),
            plusButton.heightAnchor.constraint(equalToConstant: 20),
        ])
    }

    private func changeStoryToWatched(isWatched: Bool) {
        deleteGradient()
    }

    private func deleteGradient() {
        layersInView.forEach { $0.removeFromSuperlayer() }
    }

    private func addGradient(view: UIView) {
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
        layersInView.append(imageGradient)
    }
}
