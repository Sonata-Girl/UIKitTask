// ProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Экран профиля пользователя с его сторисами и фотографиями
final class ProfileViewController: UIViewController {
    // MARK: Types

    /// Секции таблицы в контроллере
    private enum TableSections {
        ///  Информации о профиле
        case profileInfo
        ///  Сторисы
        case stories
        ///  Фотографии пользователя
        case photos
    }

    // MARK: Visual Components

    private let userBarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = .appLogo
        return imageView
    }()

    private let profileMenuBarButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFill
        button.setImage(.burgerButton, for: .normal)
        return button
    }()

    private let addPostBarButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFill
        button.setImage(.borderPlusButton, for: .normal)
        return button
    }()

    private let lockBarButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFill
        button.setImage(.lockButton, for: .normal)
        return button
    }()

    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .setVerdanaBold(withSize: 18)
        label.textColor = .label
        return label
    }()

    private lazy var mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.register(UserImagesViewCell.self, forCellReuseIdentifier: UserImagesViewCell.identifier)
        tableView.register(UserInfoViewCell.self, forCellReuseIdentifier: UserInfoViewCell.identifier)
        tableView.register(MyStoryViewCell.self, forCellReuseIdentifier: MyStoryViewCell.identifier)
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.separatorStyle = .none
        return tableView
    }()

    private lazy var refreshTableControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.translatesAutoresizingMaskIntoConstraints = false
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        return refreshControl
    }()

    // MARK: Private Properties

    private let sourceStorage = StorageService()
    private let tableSections: [TableSections] = [.profileInfo, .stories, .photos]
    private var myStories: [MyStory] = []
    private var myPhotos: [Photo] = []
    private var userPageInfo: UserPageInfo?

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fillSourcesFromBackEnd()
        configureNavigationBar()
        setupHierarchy()
        setupConstraints()
    }

    // MARK: Public Methods

    private func openSiteFromLink(link: String) {
        var link = "https://" + link.replacingOccurrences(of: "https://", with: "")
        guard let url = URL(string: link) else { return }
        let browser = BrowserViewController()
        browser.modalPresentationStyle = .formSheet
        browser.setupLink(link: url)
        present(browser, animated: true)
    }

    // MARK: Private Methods

    private func configureNavigationBar() {
        let buttonLockBarButtonItem = UIBarButtonItem(customView: lockBarButton)
        let userLabelBarButtonItem = UIBarButtonItem(customView: userNameLabel)
        navigationItem.leftBarButtonItems = [buttonLockBarButtonItem, userLabelBarButtonItem]
        let addPostBarButtonItem = UIBarButtonItem(customView: addPostBarButton)
        let profileMenuBarButtonItem = UIBarButtonItem(customView: profileMenuBarButton)
        navigationItem.rightBarButtonItems = [profileMenuBarButtonItem, addPostBarButtonItem]
    }

    private func setupHierarchy() {
        view.addSubview(mainTableView)
        mainTableView.addSubview(refreshTableControl)
    }

    private func setupConstraints() {
        setupMainCollectionViewConstraints()
    }

    private func setupMainCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    private func fillSourcesFromBackEnd() {
        userNameLabel.text = sourceStorage.getCurrentUser().name
        myStories = sourceStorage.getMyStories()
        myPhotos = sourceStorage.getMyPhotos()
        userPageInfo = sourceStorage.getUserPageInfo()
    }

    @objc private func refreshTableView(control: UIRefreshControl) {
        control.endRefreshing()
    }

    private func openFullScreenStory(myStory: MyStory) {
        let fullScreenStoryViewController = FullScreenStoryViewController()
        fullScreenStoryViewController.configureView(myStory: myStory)
        fullScreenStoryViewController.modalPresentationStyle = .formSheet
        present(fullScreenStoryViewController, animated: true)
    }

    private func openFullScreenPostImage(postImageName: String) {
        let fullPostImageViewController = FullScreenPostImageViewController()
        fullPostImageViewController.configureView(postImageName: postImageName)
        fullPostImageViewController.modalPresentationStyle = .formSheet
        present(fullPostImageViewController, animated: true)
    }
}

// MARK: UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        getNumberOfRowsInSection(section)
    }

    private func getNumberOfRowsInSection(_ section: Int) -> Int {
        switch tableSections[section] {
        case .profileInfo, .stories, .photos:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableSections[indexPath.section] {
        case .profileInfo:
            return getUserInfoCell(for: tableView, from: indexPath)
        case .stories:
            return getMyStoriesCell(for: tableView, from: indexPath)
        case .photos:
            return getUserImagesCell(for: tableView, from: indexPath)
        }
    }

    private func getUserInfoCell(for tableView: UITableView, from indexPath: IndexPath) -> UITableViewCell {
        guard
            let userPageInfo,
            let cell = tableView.dequeueReusableCell(
                withIdentifier: UserInfoViewCell.identifier,
                for: indexPath
            ) as? UserInfoViewCell else { return UITableViewCell() }

        cell.configureCell(userPageInfo: userPageInfo)
        cell.linkPressedHandler = { [weak self] link in
            self?.openSiteFromLink(link: link)
        }
        return cell
    }

    private func getMyStoriesCell(for tableView: UITableView, from indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MyStoryViewCell.identifier,
            for: indexPath
        ) as? MyStoryViewCell else { return UITableViewCell() }

        cell.configureCell(myStories: myStories)
        cell.storySelectedHandler = { [weak self] myStory in
            self?.openFullScreenStory(myStory: myStory)
        }
        return cell
    }

    private func getUserImagesCell(for tableView: UITableView, from indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: UserImagesViewCell.identifier,
            for: indexPath
        ) as? UserImagesViewCell else { return UITableViewCell() }

        cell.configureCell(photos: myPhotos)
        cell.postSelectedHandler = { [weak self] postImageName in
            self?.openFullScreenPostImage(postImageName: postImageName)
        }
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        tableSections.count
    }
}
