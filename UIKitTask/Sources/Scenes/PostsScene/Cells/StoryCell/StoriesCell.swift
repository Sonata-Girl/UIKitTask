// StoriesCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка для отображения сторисов
final class StoriesCell: UITableViewCell {
    // MARK: Constants

    static var identifier: String {
        String(describing: self)
    }

    // MARK: Visual Components

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    // MARK: Private Properties

    private var stories: [Story] = []
    private var storyCells: [StoryView] = []

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

    func configureView(stories: [Story]) {
        self.stories = stories
        updateUI()
        // TODO: storyCells.forEach { $0.updateGradient() }
    }

    // MARK: - Private methods

    private func setupHierarchy() {
        contentView.addSubview(scrollView)
    }

    private func setupScrollView() {
        contentView.backgroundColor = .white
        contentView.heightAnchor.constraint(equalToConstant: 83).isActive = true

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func updateUI() {
        guard !stories.isEmpty else { return }
        var lastStoryViewLeftAnchor = scrollView.leadingAnchor

        for (index, story) in stories.enumerated() {
            let newView = StoryView()
            newView.translatesAutoresizingMaskIntoConstraints = false

            newView.configureView(storyModel: story)
            scrollView.addSubview(newView)

            NSLayoutConstraint.activate([
                newView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
                newView.leadingAnchor.constraint(equalTo: lastStoryViewLeftAnchor, constant: 3),
                newView.widthAnchor.constraint(equalToConstant: 80),
                newView.heightAnchor.constraint(equalToConstant: 83)
            ])

            if index == stories.count - 1 {
                newView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor).isActive = true
            }

            lastStoryViewLeftAnchor = newView.trailingAnchor
            storyCells.append(newView)
        }
    }
}
