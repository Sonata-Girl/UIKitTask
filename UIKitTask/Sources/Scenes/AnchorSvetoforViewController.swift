// AnchorSvetoforViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран приложения для демонстрации поворота светофора (без стека) на NSLayoutAnchor
final class AnchorSvetoforViewController: UIViewController {
    // MARK: Visual Components

    let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()

    let redView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()

    let yellowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .yellow
        return view
    }()

    let greenView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupHierarchy()
        setupConstraints()
    }

    // MARK: Private Methods

    private func configureView() {
        view.backgroundColor = .white
    }

    private func setupHierarchy() {
        view.addSubview(mainView)
        mainView.addSubview(redView)
        mainView.addSubview(yellowView)
        mainView.addSubview(greenView)
    }

    private func setupConstraints() {
        setupMainViewConstraint()
        setupRedViewConstraint()
        setupYellowViewConstraint()
        setupGreenViewConstraint()
    }

    private func setupMainViewConstraint() {
        NSLayoutConstraint.activate([
            mainView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            mainView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            mainView.widthAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.47),
            mainView.heightAnchor.constraint(equalToConstant: 308),
        ])

        let heightAnchor = mainView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.38)
        heightAnchor.priority = .defaultHigh
        heightAnchor.isActive = true
    }

    private func setupRedViewConstraint() {
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10),
            redView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10),
            redView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10),
            redView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.3)
        ])
    }

    private func setupYellowViewConstraint() {
        NSLayoutConstraint.activate([
            yellowView.topAnchor.constraint(equalTo: redView.bottomAnchor, constant: 5),
            yellowView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10),
            yellowView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10),
            yellowView.heightAnchor.constraint(equalTo: redView.heightAnchor)
        ])
    }

    private func setupGreenViewConstraint() {
        NSLayoutConstraint.activate([
            greenView.topAnchor.constraint(equalTo: yellowView.bottomAnchor, constant: 5),
            greenView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10),
            greenView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10),
            greenView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10),
        ])
    }
}
