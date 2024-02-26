// VFLSvetoforViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран приложения для демонстрации поворота светофора (без стека) на Visual Format Language
final class VFLSvetoforViewController: UIViewController {
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

    private var viewVLFMap: [String: UIView] = [:]

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupHierarchy()
        setupConstraints()
        setCircles()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupMainViewConstraint()
        setCircles()
    }

    // MARK: Private Methods

    private func configureView() {
        view.backgroundColor = .white
    }

    private func setupHierarchy() {
        viewVLFMap = [
            "superView": view,
            "mainView": mainView,
            "redView": redView,
            "yellowView": yellowView,
            "greenView": greenView
        ]
        view.addSubview(mainView)
        mainView.addSubview(redView)
        mainView.addSubview(yellowView)
        mainView.addSubview(greenView)
    }

    private func setCircles() {
        let isLandscape = view.bounds.size.width > view.bounds.size.height
        let heightYellowView = isLandscape ? view.bounds.size.width * 0.13 : view.bounds.size.height * 0.3
        redView.layer.cornerRadius = heightYellowView / 2
        yellowView.layer.cornerRadius = heightYellowView / 2
        greenView.layer.cornerRadius = heightYellowView / 2
    }

    private func setupConstraints() {
        setupMainViewConstraint()
    }

    private func setupMainViewConstraint() {
        deleteAllConstraints()

        let isLandscape = view.bounds.size.width > view.bounds.size.height
        let heightYellowView = isLandscape ? view.bounds.size.width * 0.13 : view.bounds.size.height * 0.3
        let widthYellowView = heightYellowView
        let heightMainView = heightYellowView * 3 + (10 * 4)
        let widthMainView = widthYellowView + (10 * 2)

        let metrics = [
            "heightYellowView": heightYellowView,
            "widthYellowView": widthYellowView,
            "heightMainView": heightMainView,
            "widthMainView": widthMainView
        ] as [String: Any]

        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
            withVisualFormat: "V:[superView]-(<=1)-[yellowView(heightYellowView)]",
            options: .alignAllCenterX,
            metrics: metrics,
            views: viewVLFMap
        ))

        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
            withVisualFormat: "H:[superView]-(<=1)-[yellowView(widthYellowView)]",
            options: .alignAllCenterY,
            metrics: metrics,
            views: viewVLFMap
        ))

        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
            withVisualFormat: "V:[superView]-(<=1)-[mainView(heightMainView)]",
            options: .alignAllCenterX,
            metrics: metrics,
            views: viewVLFMap
        ))

        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
            withVisualFormat: "H:[superView]-(<=1)-[mainView(widthMainView)]",
            options: .alignAllCenterY,
            metrics: metrics,
            views: viewVLFMap
        ))

        var visualFormat = "V:[superView]-(<=1)-[redView(heightYellowView)]"
        visualFormat += "-[yellowView(==redView)]"
        visualFormat += "-[greenView(==redView)]-(<=1)-[superView]"
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
            withVisualFormat: visualFormat,
            options: [],
            metrics: metrics,
            views: viewVLFMap
        ))

        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
            withVisualFormat: "H:[redView(==yellowView)]-(\(-(10 + widthYellowView)))-[mainView]",
            options: [],
            metrics: metrics,
            views: viewVLFMap
        ))

        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
            withVisualFormat: "H:[greenView(==yellowView)]-(\(-(10 + widthYellowView)))-[mainView]",
            options: [],
            metrics: metrics,
            views: viewVLFMap
        ))
    }

    private func setupMainViewConstraintVariantTwo() {
        deleteAllConstraints()

        let isLandscape = view.bounds.size.width > view.bounds.size.height
        let heightMainView = isLandscape ? view.bounds.size.width * 0.4 : view.bounds.size.height * 0.8
        let widthMainView = heightMainView * 0.38
        let heightViews = (heightMainView - (10 * 4)) / 3

        let metrics = [
            "heightViews": heightViews,
            "heightMainView": heightMainView,
            "widthMainView": widthMainView
        ] as [String: Any]

        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
            withVisualFormat: "V:[superView]-(<=1)-[mainView(heightMainView)]",
            options: .alignAllCenterX,
            metrics: metrics,
            views: viewVLFMap
        ))

        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
            withVisualFormat: "H:[superView]-(<=1)-[mainView(widthMainView)]",
            options: .alignAllCenterY,
            metrics: metrics,
            views: viewVLFMap
        ))

        var visualFormat = "V:|-(10)-[redView(heightViews)]"
        visualFormat += "-[yellowView(heightViews)]"
        visualFormat += "-[greenView(heightViews)]-(10)-|"

        mainView.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: visualFormat,
                options: [],
                metrics: metrics,
                views: viewVLFMap
            )
        )

        mainView.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-(10)-[redView]-(10)-|",
                options: [],
                metrics: metrics,
                views: viewVLFMap
            )
        )

        mainView.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-(10)-[yellowView]-(10)-|",
                options: [],
                metrics: metrics,
                views: viewVLFMap
            )
        )

        mainView.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-(10)-[greenView]-(10)-|",
                options: [],
                metrics: metrics,
                views: viewVLFMap
            )
        )
    }

    private func deleteAllConstraints() {
        for constraint in view.constraints {
            view.removeConstraint(constraint)
        }

        for constraint in mainView.constraints {
            mainView.removeConstraint(constraint)
        }

        for constraint in redView.constraints {
            redView.removeConstraint(constraint)
        }

        for constraint in yellowView.constraints {
            yellowView.removeConstraint(constraint)
        }

        for constraint in greenView.constraints {
            greenView.removeConstraint(constraint)
        }
    }
}
