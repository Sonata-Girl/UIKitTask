// VFLViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран для тестов VFL
final class VFLViewController: UIViewController {
    // MARK: Types

    // MARK: Constants

    // MARK: IBOutlet

    // MARK: Visual Components

    let redView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()

    let blueView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()

    // MARK: Public Properties

    // MARK: Private Properties

    // MARK: Initializers

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupHierarchy()
        setupConstraints()
    }

    // MARK: Public methods

    // MARK: IBAction или @objc (not private)

    // MARK: Private Methods

    private func configureView() {
        view.backgroundColor = .white
    }

    private func setupHierarchy() {
        view.addSubview(redView)
        view.addSubview(blueView)
    }

    private func setupConstraints() {
        setupRedViewConstraint()
        setupBlueViewConstraint()

        let viewVLF = ["redView": redView, "blueView": blueView]
        let metrics = [
            "heightMultiplier": 0.4,
            "height": 100,
            "width": view.bounds.size.width / 3,
            "top": view.bounds.size.height / 2
        ]

        view.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-top-[redView(height)]|",
                options: [],
                metrics: metrics,
                views: viewVLF
            )
        )

        view.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-top-[blueView(height)]|",
                options: [],
                metrics: metrics,
                views: viewVLF
            )
        )
        // H - это горизонталь V вертикаль
        // |-это части экрана
        // ]-[ - 8 пунктов расстояние между вью
        // ]-(50)-[ - 50 пунктов между вью
        // [redView] - указываем вью из словаря
        view.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-[redView(width)]-(50)-[blueView(width)]-|",
                options: [],
                metrics: metrics,
                views: viewVLF
            )
        )
    }

    private func setupRedViewConstraint() {}

    private func setupBlueViewConstraint() {}

    // MARK: - IBAction или @objc (private)
}

// VFLSvetoforViewController.swift
// Copyright © RoadMap. All rights reserved.
