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

    // MARK: Constants

    private enum Constants {
        static let titleRoastingScreen = "Уточните обжарку зеренъ"
    }

    // MARK: IBOutlet

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

    // MARK: Public Properties

    // MARK: Private Properties

    private let tableSections: [TableSections] = [.stories, .firstPost, .recommendations, .posts]
    private var stories: [Story] = []
    private var posts: [Post] = []
    private var recommendations: [User] = []

    // MARK: Initializers

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromBackEnd()

        configureNavigationBar()
        configureView()
        setupHierarchy()
        setupUI()
    }

    // MARK: Public methods

    // MARK: IBAction или @objc (not private)

    // MARK: Private Methods

    private func configureNavigationBar() {
        var tabBarItem = UIBarButtonItem(customView: appLogoBarImage)
        navigationItem.leftBarButtonItem = tabBarItem
        tabBarItem = UIBarButtonItem(customView: messagesBarButton)
        navigationItem.rightBarButtonItem = tabBarItem
    }

    private func configureView() {}

    private func setupHierarchy() {
        view.addSubview(mainTableView)
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
        let userMe = User(name: "Ваша история", avatarImage: "myAvatar")
        let userLavanda = User(name: "lavanda123", avatarImage: "avatarLavanda")

        stories.append(Story(user: userMe, isYour: true))
        stories.append(Story(user: userLavanda, isYour: false))
        stories.append(Story(user: userLavanda, isYour: false))
        stories.append(Story(user: userLavanda, isYour: false))
        stories.append(Story(user: userLavanda, isYour: false))
        stories.append(Story(user: userLavanda, isYour: false))
        stories.append(Story(user: userLavanda, isYour: false))
        stories.append(Story(user: userLavanda, isYour: false))

        recommendations.append(User(name: "сrimea_082", avatarImage: "recommendOne"))
        recommendations.append(User(name: "mary_pol", avatarImage: "recommendTwo"))

        let userTur = User(name: "tur_v_dagestan", avatarImage: "avatarTurDagestan")
        let imagesTur: [String] = ["postOne", "postTwo", "postOne", "postTwo"]
        let comment = "Насладитесь красотой природы. Забронировать тур в Дагестан можно уже сейчас!"
        posts.append(Post(user: userTur, images: imagesTur, comment: comment, likes: 201))
    }

    // MARK: IBAction или @objc (private)
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
            cell.configureView(post: posts.dropFirst()[indexPath.row])
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
        tableSections.count - 1
    }
}
