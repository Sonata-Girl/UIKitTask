//
//  BrowserViewController.swift
//  UIKitTask
//
//  Created by Sonata Girl on 22.02.2024.
//

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

    // MARK: Private Properties
    // MARK: Initializers
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupConstraints()
    }

    // MARK: Public methods
    
    private func setupLink(link: URL) {
        webKitView.load(URLRequest(url: link))
    }

    // MARK: Private Methods

    private func setupHierarchy() {
        view.addSubview(bottomNavigationView)
        [
            backwardButton,
            forwardButton,
            reloadButton
        ].forEach { bottomNavigationView.addSubview($0) }
    }

    private func setupConstraints() {
        setupBottomNavigationViewConstraint()
        setupBackwardButtonConstraint()
        setupForwardButtonConstraint()
        setupReloadButtonConstraint()
    }

    private func setupBottomNavigationViewConstraint() {

    }

    private func setupBackwardButtonConstraint() {

    }

    private func setupForwardButtonConstraint() {

    }

    private func setupReloadButtonConstraint() {

    }


    @objc private func goPreviousPage() {

    }

    @objc private func goNextPage() {

    }

    @objc private func reloadPage() {

    }
}
