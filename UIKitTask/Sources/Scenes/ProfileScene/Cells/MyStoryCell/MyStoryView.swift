// MyStoryView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Вью для отображения кругляшка и подписи для сторис текущего пользователя
final class MyStoryView: UIView {
    // MARK: Visual Components

    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 27
        return imageView
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .setVerdana(withSize: 10)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()

    // MARK: Public Properties

    var storySelectedHandler: ((MyStory) -> ())?

    // MARK: Privates Properties

    private var viewLayers: [CALayer] = []
    private var myStory: MyStory?

    // MARK: Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)

        isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(storySelected))
        addGestureRecognizer(tap)

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

    func configureView(myStory: MyStory) {
        self.myStory = myStory

        mainImageView.image = UIImage(named: myStory.imageName)
        descriptionLabel.text = myStory.description
    }

    func updateGradient() {
        addGradient(view: mainImageView)
    }

    // MARK: Private methods

    private func setupHierarchy() {
        [
            mainImageView,
            descriptionLabel,
        ].forEach { addSubview($0) }
    }

    private func setupConstraints() {
        setupMainImageViewConstraints()
        setupDescriptionLabelConstraints()
    }

    private func setupMainImageViewConstraints() {
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            mainImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainImageView.heightAnchor.constraint(equalToConstant: 55),
            mainImageView.widthAnchor.constraint(equalToConstant: 55)
        ])
    }

    private func setupDescriptionLabelConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 5),
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func deleteGradient() {
        viewLayers.forEach { $0.removeFromSuperlayer() }
    }

    private func addGradient(view: UIView) {
        guard viewLayers.isEmpty else { return }
        let imageGradient = CAGradientLayer()
        imageGradient.colors = [UIColor.systemGray3.cgColor, UIColor.systemGray3.cgColor]
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

    @objc private func storySelected() {
        guard let myStory else { return }
        storySelectedHandler?(myStory)
    }
}
