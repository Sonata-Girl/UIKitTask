// RecommendationCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка для отображения рекомендуемых пользователей
final class RecommendationCell: UITableViewCell {
    // MARK: Types

    static var identifier: String {
        String(describing: self)
    }

    // MARK: Constants

    private enum Constants {
        static let titleView = "Рекомендуем вам"
        static let showAllButtonTitle = "Все"
    }

    // MARK: Visual Components

    private let sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .setVerdanaBold(withSize: 10)
        label.text = Constants.titleView
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()

    private let showAllButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.showAllButtonTitle, for: .normal)
        button.titleLabel?.font = .setVerdanaBold(withSize: 10)
        button.contentHorizontalAlignment = .right
        button.setTitleColor(.appBlue, for: .normal)
        return button
    }()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    // MARK: Private Properties

    private var recommendations: [User] = []
    private var recommendationCells: [RecommendationView] = []

    // MARK: Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupScrollView()
        updateUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHierarchy()
    }

    // MARK: Public methods

    func configureView(recommendations: [User]) {
        self.recommendations = recommendations
        updateUI()
    }

    // MARK: - Private methods

    private func setupHierarchy() {
        [
            sectionTitleLabel,
            showAllButton,
            scrollView
        ].forEach { contentView.addSubview($0) }
    }

    private func setupScrollView() {
        contentView.backgroundColor = .appLightBlue
        contentView.heightAnchor.constraint(equalToConstant: 270).isActive = true

        NSLayoutConstraint.activate([
            sectionTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 9),
            sectionTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            sectionTitleLabel.widthAnchor.constraint(equalToConstant: 107),
            sectionTitleLabel.heightAnchor.constraint(equalToConstant: 15),

        ])

        NSLayoutConstraint.activate([
            showAllButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 9),
            showAllButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            showAllButton.widthAnchor.constraint(equalToConstant: 107),
            showAllButton.heightAnchor.constraint(equalToConstant: 15),
        ])

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 45),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25)
        ])
    }

    private func updateUI() {
        guard !recommendations.isEmpty else { return }
        var lastStoryViewLeftAnchor = scrollView.leadingAnchor

        for (index, user) in recommendations.enumerated() {
            let newView = RecommendationView()
            newView.translatesAutoresizingMaskIntoConstraints = false

            newView.configureView(recommendation: user)
            scrollView.addSubview(newView)

            NSLayoutConstraint.activate([
                newView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
                newView.leadingAnchor.constraint(equalTo: lastStoryViewLeftAnchor, constant: 20),
                newView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
                newView.widthAnchor.constraint(equalToConstant: 185),
                newView.heightAnchor.constraint(equalToConstant: 200)
            ])

            if index == recommendations.count - 1 {
                newView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor).isActive = true
            }

            lastStoryViewLeftAnchor = newView.trailingAnchor
            recommendationCells.append(newView)
        }
    }
}
