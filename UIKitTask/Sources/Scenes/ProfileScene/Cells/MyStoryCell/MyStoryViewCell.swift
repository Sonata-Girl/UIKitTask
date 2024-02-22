// MyStoryViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Ячейка для отображения моих сторис
final class MyStoryViewCell: UITableViewCell {
    // MARK: Constants

    static var identifier: String {
        String(describing: self)
    }

    // MARK: Visual Components

    private var fullCellSizeScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: Private Properties

    private var myStories: [MyStory] = []
    private var myStoryCells: [MyStoryView] = []

    // MARK: Initializers

    // MARK: Life Cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHierarchy()
        setupConstraints()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        myStories.removeAll()
        clearScrollView()
    }

    // MARK: Public methods

    func configureCell(myStories: [MyStory]) {
        self.myStories = myStories
        fillScrollView()
    }

    // MARK: Private Methods

    private func setupHierarchy() {
        contentView.addSubview(fullCellSizeScrollView)
        fullCellSizeScrollView.addSubview(containerView)
    }

    private func setupConstraints() {
//        contentView.heightAnchor.constraint(equalToConstant: 73).isActive = true

        setupFullCellSizeScrollViewConstraint()
        setupContainerViewConstraint()
    }

    private func setupFullCellSizeScrollViewConstraint() {
        NSLayoutConstraint.activate([
            fullCellSizeScrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            fullCellSizeScrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            fullCellSizeScrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            fullCellSizeScrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    private func setupContainerViewConstraint() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: fullCellSizeScrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: fullCellSizeScrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: fullCellSizeScrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: fullCellSizeScrollView.bottomAnchor),
            containerView.heightAnchor.constraint(equalTo: fullCellSizeScrollView.heightAnchor),
        ])
    }

    private func fillScrollView() {
        guard !myStories.isEmpty else { return }
        var lastStoryViewLeftAnchor = containerView.leadingAnchor

        for (index, myStory) in myStories.enumerated() {
            let newView = MyStoryView()
            newView.translatesAutoresizingMaskIntoConstraints = false

            newView.configureView(myStory: myStory)
            containerView.addSubview(newView)

            NSLayoutConstraint.activate([
                newView.topAnchor.constraint(equalTo: containerView.topAnchor),
                newView.leadingAnchor.constraint(equalTo: lastStoryViewLeftAnchor, constant: 2),
                newView.widthAnchor.constraint(equalToConstant: 68),
                newView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
            ])

            if index == myStories.count - 1 {
                newView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
            }

            lastStoryViewLeftAnchor = newView.trailingAnchor
            myStoryCells.append(newView)
        }
    }

    private func clearScrollView() {
        containerView.subviews.forEach { $0.removeFromSuperview() }
    }
}
