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

    private let contentContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: Private Properties

    private var stories: [Story] = []
    private var storyCells: [StoryView] = []

    // MARK: Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupScrollView()
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
    }

    // MARK: - Private methods

    private func setupHierarchy() {
        contentView.addSubview(scrollView)
        scrollView.addSubview(contentContainerView)
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

        let widthConstraint = contentContainerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        widthConstraint.priority = UILayoutPriority(250)
        NSLayoutConstraint.activate([
            contentContainerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentContainerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentContainerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentContainerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentContainerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            widthConstraint,
        ])
    }

    private func updateUI() {
        guard !stories.isEmpty else { return }
        var lastStoryViewLeftAnchor = contentContainerView.leadingAnchor

        for (index, story) in stories.enumerated() {
            let newView = StoryView()
            newView.translatesAutoresizingMaskIntoConstraints = false

            newView.configureView(storyModel: story)
            contentContainerView.addSubview(newView)

            NSLayoutConstraint.activate([
                newView.topAnchor.constraint(equalTo: contentContainerView.topAnchor),
                newView.leadingAnchor.constraint(equalTo: lastStoryViewLeftAnchor, constant: 3),
                newView.widthAnchor.constraint(equalToConstant: 80),
                newView.bottomAnchor.constraint(equalTo: contentContainerView.bottomAnchor)
            ])

            if index == stories.count - 1 {
                newView.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor).isActive = true
            }

            lastStoryViewLeftAnchor = newView.trailingAnchor
            storyCells.append(newView)
        }
    }
}
