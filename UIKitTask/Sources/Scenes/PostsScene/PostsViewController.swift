// PostsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Стартовый экран, список постов , сторис, рекомендации
final class PostsViewController: UIViewController {
    // MARK: Types

    private enum TableSections {
        case firstPost
        case stories
        case posts
        case recommendations
    }

    // MARK: Visual Components

    private let appLogoBarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = .appLogo
        return imageView
    }()

    private let messagesBarButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFill
        button.setImage(.messagesButtonBar, for: .normal)
        return button
    }()

    private lazy var mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.register(StoriesCell.self, forCellReuseIdentifier: StoriesCell.identifier)
        tableView.register(RecommendationCell.self, forCellReuseIdentifier: RecommendationCell.identifier)
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.identifier)
        tableView.dataSource = self
        tableView.separatorStyle = .none
        return tableView
    }()

    private lazy var refreshTableControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.translatesAutoresizingMaskIntoConstraints = false
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        return refreshControl
    }()

    // MARK: Private Properties

    private let dataBase = DataStorageService.shared
    private let tableSections: [TableSections] = [.stories, .firstPost, .recommendations, .posts]
    private var stories: [Story] = []
    private var posts: [Post] = []
    private var recommendations: [User] = []

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromBackEnd()

        configureNavigationBar()
        setupHierarchy()
        setupUI()
    }

    // MARK: Private Methods

    private func configureNavigationBar() {
        var tabBarItem = UIBarButtonItem(customView: appLogoBarImage)
        navigationItem.leftBarButtonItem = tabBarItem
        tabBarItem = UIBarButtonItem(customView: messagesBarButton)
        navigationItem.rightBarButtonItem = tabBarItem
    }

    private func setupHierarchy() {
        view.addSubview(mainTableView)
        mainTableView.addSubview(refreshTableControl)
    }

    private func setupUI() {
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    private func getDataFromBackEnd() {
        stories = dataBase.getStories()
        posts = dataBase.getPosts()
        recommendations = dataBase.getRecommendations()
    }

    @objc private func refreshTable(control: UIRefreshControl) {
//        mainTableView.backgroundColor =
        control.endRefreshing()
    }
}

// MARK: UITableViewDataSource

extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        getNumberOfRowsInSection(section)
    }

    private func getNumberOfRowsInSection(_ section: Int) -> Int {
        switch tableSections[section] {
        case .stories:
            return 1
        case .firstPost:
            return 1
        case .recommendations:
            return 1
        case .posts:
            return posts.dropFirst().count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableSections[indexPath.section] {
        case .stories:
            return getStoryCell(for: tableView, from: indexPath)
        case .firstPost:
            return getPostsCell(for: tableView, from: indexPath, firstPost: true)
        case .recommendations:
            return getRecommendationCell(for: tableView, from: indexPath)
        case .posts:
            return getPostsCell(for: tableView, from: indexPath, firstPost: false)
        }
    }

    private func getStoryCell(for tableView: UITableView, from indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: StoriesCell.identifier,
                for: indexPath
            ) as? StoriesCell else { return UITableViewCell() }

        cell.configureView(stories: stories)
        return cell
    }

    private func getPostsCell(
        for tableView: UITableView,
        from indexPath: IndexPath,
        firstPost: Bool
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PostCell.identifier,
            for: indexPath
        ) as? PostCell else { return UITableViewCell() }

        if firstPost {
            cell.configureView(post: posts[indexPath.row])
        } else {
            guard posts.count > 1 else { return UITableViewCell() }
            cell.configureView(post: posts.dropFirst()[indexPath.row + 1])
        }
        return cell
    }

    private func getRecommendationCell(for tableView: UITableView, from indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: RecommendationCell.identifier,
                for: indexPath
            ) as? RecommendationCell else { return UITableViewCell() }

        cell.configureView(recommendations: recommendations)
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        tableSections.count
    }
}
