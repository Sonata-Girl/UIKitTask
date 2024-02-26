// ConstraintSvetoforViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран приложения для демонстрации поворота светофора (без стека) на NSLayoutConstraint
final class ConstraintSvetoforViewController: UIViewController {
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
        NSLayoutConstraint(
            item: mainView,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: view.safeAreaLayoutGuide,
            attribute: .centerY,
            multiplier: 1,
            constant: 0
        ).isActive = true
        NSLayoutConstraint(
            item: mainView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view.safeAreaLayoutGuide,
            attribute: .centerX,
            multiplier: 1,
            constant: 0
        ).isActive = true
        NSLayoutConstraint(
            item: mainView,
            attribute: .width,
            relatedBy: .equal,
            toItem: mainView,
            attribute: .height,
            multiplier: 0.47,
            constant: 0
        ).isActive = true
        NSLayoutConstraint(
            item: mainView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 308
        ).isActive = true

        let heightConstraint = NSLayoutConstraint(
            item: mainView,
            attribute: .height,
            relatedBy: .equal,
            toItem: view,
            attribute: .height,
            multiplier: 0.38,
            constant: 0
        )
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
    }

    private func setupRedViewConstraint() {
        NSLayoutConstraint(
            item: redView,
            attribute: .top,
            relatedBy: .equal,
            toItem: mainView,
            attribute: .top,
            multiplier: 1,
            constant: 10
        ).isActive = true
        NSLayoutConstraint(
            item: redView,
            attribute: .leading,
            relatedBy: .equal,
            toItem: mainView,
            attribute: .leading,
            multiplier: 1,
            constant: 10
        ).isActive = true
        NSLayoutConstraint(
            item: redView,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: mainView,
            attribute: .trailing,
            multiplier: 1,
            constant: -10
        ).isActive = true
        NSLayoutConstraint(
            item: redView,
            attribute: .height,
            relatedBy: .equal,
            toItem: mainView,
            attribute: .height,
            multiplier: 0.3,
            constant: 0
        ).isActive = true
    }

    private func setupYellowViewConstraint() {
        NSLayoutConstraint(
            item: yellowView,
            attribute: .top,
            relatedBy: .equal,
            toItem: redView,
            attribute: .bottom,
            multiplier: 1,
            constant: 5
        ).isActive = true
        NSLayoutConstraint(
            item: yellowView,
            attribute: .leading,
            relatedBy: .equal,
            toItem: mainView,
            attribute: .leading,
            multiplier: 1,
            constant: 10
        ).isActive = true
        NSLayoutConstraint(
            item: yellowView,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: mainView,
            attribute: .trailing,
            multiplier: 1,
            constant: -10
        ).isActive = true
        NSLayoutConstraint(
            item: yellowView,
            attribute: .height,
            relatedBy: .equal,
            toItem: redView,
            attribute: .height,
            multiplier: 1,
            constant: 0
        ).isActive = true
    }

    private func setupGreenViewConstraint() {
        NSLayoutConstraint(
            item: greenView,
            attribute: .top,
            relatedBy: .equal,
            toItem: yellowView,
            attribute: .bottom,
            multiplier: 1,
            constant: 5
        ).isActive = true
        NSLayoutConstraint(
            item: greenView,
            attribute: .leading,
            relatedBy: .equal,
            toItem: mainView,
            attribute: .leading,
            multiplier: 1,
            constant: 10
        ).isActive = true
        NSLayoutConstraint(
            item: greenView,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: mainView,
            attribute: .trailing,
            multiplier: 1,
            constant: -10
        ).isActive = true
        NSLayoutConstraint(
            item: greenView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: mainView,
            attribute: .bottom,
            multiplier: 1,
            constant: -10
        ).isActive = true
    }
}
