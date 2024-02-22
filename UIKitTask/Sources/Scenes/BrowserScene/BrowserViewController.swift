// BrowserViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
import WebKit

/// Экран для отображения ссылок, браузер
final class BrowserViewController: UIViewController {
    // MARK: Visual Components

    private let webKitView: WKWebView = {
        let webKit = WKWebView()
        webKit.translatesAutoresizingMaskIntoConstraints = false
        return webKit
    }()

    private let bottomNavigationView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        return view
    }()

    private lazy var backwardButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.backwardButton, for: .normal)
        button.tintColor = .label
        button.addTarget(self, action: #selector(goPreviousPage), for: .touchUpInside)
        return button
    }()

    private lazy var forwardButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.forwardButton, for: .normal)
        button.tintColor = .label
        button.addTarget(self, action: #selector(goNextPage), for: .touchUpInside)
        return button
    }()

    private lazy var reloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.reloadButton, for: .normal)
        button.tintColor = .label
        button.addTarget(self, action: #selector(reloadPage), for: .touchUpInside)
        return button
    }()

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupConstraints()
    }

    // MARK: Public methods

    func setupLink(link: URL) {
        webKitView.load(URLRequest(url: link))
    }

    // MARK: Private Methods

    private func setupHierarchy() {
        view.addSubview(webKitView)
        view.addSubview(bottomNavigationView)
        [
            backwardButton,
            forwardButton,
            reloadButton
        ].forEach { bottomNavigationView.addSubview($0) }
    }

    private func setupConstraints() {
        setupWebKitViewConstraint()
        setupBottomNavigationViewConstraint()
        setupBackwardButtonConstraint()
        setupForwardButtonConstraint()
        setupReloadButtonConstraint()
    }

    private func setupWebKitViewConstraint() {
        NSLayoutConstraint.activate([
            webKitView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webKitView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            webKitView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }

    private func setupBottomNavigationViewConstraint() {
        NSLayoutConstraint.activate([
            bottomNavigationView.topAnchor.constraint(equalTo: webKitView.bottomAnchor),
            bottomNavigationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomNavigationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomNavigationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomNavigationView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupBackwardButtonConstraint() {
        NSLayoutConstraint.activate([
            backwardButton.leadingAnchor.constraint(equalTo: bottomNavigationView.leadingAnchor, constant: 15),
            backwardButton.centerYAnchor.constraint(equalTo: bottomNavigationView.centerYAnchor),
            backwardButton.heightAnchor.constraint(equalToConstant: 24),
            backwardButton.widthAnchor.constraint(equalToConstant: 24),
        ])
    }

    private func setupForwardButtonConstraint() {
        NSLayoutConstraint.activate([
            forwardButton.leadingAnchor.constraint(equalTo: backwardButton.trailingAnchor, constant: 35),
            forwardButton.centerYAnchor.constraint(equalTo: bottomNavigationView.centerYAnchor),
            forwardButton.heightAnchor.constraint(equalToConstant: 24),
            forwardButton.widthAnchor.constraint(equalToConstant: 24),
        ])
    }

    private func setupReloadButtonConstraint() {
        NSLayoutConstraint.activate([
            reloadButton.trailingAnchor.constraint(equalTo: bottomNavigationView.trailingAnchor, constant: -30),
            reloadButton.centerYAnchor.constraint(equalTo: bottomNavigationView.centerYAnchor),
            reloadButton.heightAnchor.constraint(equalToConstant: 24),
            reloadButton.widthAnchor.constraint(equalToConstant: 24),
        ])
    }

    @objc private func goPreviousPage() {
        guard webKitView.canGoBack else { return }
        webKitView.goBack()
    }

    @objc private func goNextPage() {
        guard webKitView.canGoForward else { return }
        webKitView.goForward()
    }

    @objc private func reloadPage() {
        webKitView.reload()
    }
}


