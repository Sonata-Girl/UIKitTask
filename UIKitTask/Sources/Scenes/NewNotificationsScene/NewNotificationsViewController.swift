// NewNotificationsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран новых уведомлений и событий
final class NewNotificationsViewController: UIViewController {
    // MARK: Constants

    private enum Constants {
        static let titleScreen = "Уведомления"
    }

    // MARK: Types

    private enum TableSections: String {
        case subscribeRequests = "Запросы на подписку"
        case today = "Today"
        case week = "На этой неделе"
    }

    // MARK: Visual Components

    private lazy var mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.register(NewNotificationViewCell.self, forCellReuseIdentifier: NewNotificationViewCell.identifier)
        tableView.register(NewUserViewCell.self, forCellReuseIdentifier: NewUserViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
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

    private let dataStorage = DataStorageService()
    private let tableSections: [TableSections] = [.subscribeRequests, .today, .week]
    private var todayNews: [NewNotification] = []
    private var weekNews: [NewNotification] = []

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromBackEnd()
        configureNavigationBar()
        setupHierarchy()
        setupConstraints()
    }

    // MARK: Private Methods

    private func configureNavigationBar() {
        navigationItem.title = Constants.titleScreen
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupHierarchy() {
        view.addSubview(mainTableView)
        mainTableView.addSubview(refreshTableControl)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    private func getDataFromBackEnd() {
        todayNews = dataStorage.getNews()
            .filter { Date().timeIntervalSince($0.date) < 86400 }
            .sorted { $0.date > $1.date }

        weekNews = dataStorage.getNews()
            .filter { Date().timeIntervalSince($0.date) > 86400 }
            .sorted { $0.date > $1.date }
    }

    @objc private func refreshTableView(control: UIRefreshControl) {
        getDataFromBackEnd()
        mainTableView.reloadData()
        control.endRefreshing()
    }
}

// MARK: UITableViewDataSource

extension NewNotificationsViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            switch tableSections[indexPath.section] {
            case
                .subscribeRequests: break
            case .today:
                todayNews.remove(at: indexPath.row)
            case .week:
                weekNews.remove(at: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UITableViewHeaderFooterView()
        header.textLabel?.text = tableSections[section].rawValue
        header.textLabel?.textColor = .black
        return header
    }
}

// MARK: UITableViewDataSource

extension NewNotificationsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        tableSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableSections[section] {
        case .subscribeRequests:
            return 1
        case .today:
            return todayNews.count
        case .week:
            return weekNews.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableSections[indexPath.section] {
        case .subscribeRequests:
            let cell = UITableViewCell()
            cell.heightAnchor.constraint(equalToConstant: 1).isActive = true
            return cell
        case .today:
            return getNewNotificationCell(for: tableView, from: indexPath, source: todayNews)
        case .week:
            return getNewNotificationCell(for: tableView, from: indexPath, source: weekNews)
        }
    }

    private func getNewNotificationCell(
        for tableView: UITableView,
        from indexPath: IndexPath,
        source: [NewNotification]
    ) -> UITableViewCell {
        switch source[indexPath.row].type {
        case .newLikeOnComment, .userCallYou:
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: NewNotificationViewCell.identifier,
                    for: indexPath
                ) as? NewNotificationViewCell else { return UITableViewCell() }
            cell.configureCell(newNotification: source[indexPath.row], currentUser: dataBase.getCurrentUser())
            return cell
        case .newFollower, .newUser:
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: NewUserViewCell.identifier,
                    for: indexPath
                ) as? NewUserViewCell else { return UITableViewCell() }
            cell.configureCell(newNotification: source[indexPath.row], currentUser: dataBase.getCurrentUser())
            return cell
        }
    }
}
