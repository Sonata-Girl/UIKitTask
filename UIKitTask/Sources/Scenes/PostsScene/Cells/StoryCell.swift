// StoryCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка для отображения сторис
final class StoryCell: UIView {
    // MARK: - Visual Components

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 20
        return imageView
    }()

    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .setVerdana(withSize: 14)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()

    private let plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .red
        button.isHidden = true
        return button
    }()

    // MARK: Privates Properties
    private var layersInView = [CALayer]()
    private var model: Story?

    // MARK: - Initializers

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

    // MARK: - Public methods

    func configureView(storyModel: Story) {
        model = storyModel
        guard let model else { return }
        imageView.image = UIImage(named: model.user.avatarImage)
        userNameLabel.text = model.user.name
        if model.isYour {
            plusButton.isHidden = false
        } else {
            addGradient(for: imageView)
        }
    }

    // MARK: - Private methods

    private func setupHierarchy() {
        [
            imageView,
            userNameLabel,
        ].forEach { addSubview($0) }

        imageView.addSubview(plusButton)
    }

    private func setupUI() {
        backgroundColor = .white

       NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            trailingAnchor.constraint(equalTo: imageView.trailingAnchor,constant: 10)
       ])

        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            userNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            trailingAnchor.constraint(equalTo: userNameLabel.trailingAnchor,constant: 10),
            bottomAnchor.constraint(equalTo: userNameLabel.bottomAnchor)
        ])
    }

    private func changeStoryToWatсhed(isWatched: Bool) {
        deleteGradient()
    }

    private func addGradient(for uiComponent: UIView) {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.yellow, UIColor.orange, UIColor.red]
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        gradient.frame = uiComponent.bounds

        let shape = CAShapeLayer()
        shape.path = UIBezierPath(
            arcCenter: CGPoint(x: uiComponent.bounds.height / 2,
                               y: uiComponent.bounds.height / 2),
            radius: uiComponent.bounds.height / 2,
            startAngle: 0, 
            endAngle: CGFloat.pi * 2,
            clockwise: true
        ).cgPath
        gradient.mask = shape
        uiComponent.layer.insertSublayer(gradient, at: 0)
        layersInView.append(gradient)
    }

    private func deleteGradient() {
        layersInView.forEach { $0.removeFromSuperlayer() }
    }
}
