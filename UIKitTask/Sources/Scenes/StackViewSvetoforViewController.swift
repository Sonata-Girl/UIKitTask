// StackViewSvetoforViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран приложения для демонстрации поворота светофора, расположенного в стэке
final class StackViewSvetoforViewController: UIViewController {
    // MARK: Visual Components

    let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 5
        stack.backgroundColor = .gray
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
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
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(redView)
        mainStackView.addArrangedSubview(yellowView)
        mainStackView.addArrangedSubview(greenView)
    }

    private func setupConstraints() {
        setupMainStackViewConstraint()
    }

    private func setupMainStackViewConstraint() {
        mainStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        mainStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        mainStackView.widthAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.47).isActive = true
        mainStackView.heightAnchor.constraint(equalToConstant: 308).isActive = true
        let heightAnchor = mainStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.38)
        heightAnchor.priority = .defaultHigh
        heightAnchor.isActive = true
    }
}
