// MainViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Стартовый контроллер приложения светофор
final class MainViewController: UIViewController {
    // MARK: IBAction

    @IBAction private func stackViewButtonPressed(_ sender: UIButton) {
        let stackViewSvetoforViewController = StackViewSvetoforViewController()
        stackViewSvetoforViewController.modalPresentationStyle = .formSheet
        present(stackViewSvetoforViewController, animated: true)
    }

    @IBAction private func nsLayoutAnchorButtonPressed(_ sender: UIButton) {
        let anchorSvetoforViewController = AnchorSvetoforViewController()
        anchorSvetoforViewController.modalPresentationStyle = .formSheet
        present(anchorSvetoforViewController, animated: true)
    }

    @IBAction private func nsLayoutConstraintButtonPressed(_ sender: UIButton) {
        let constraintSvetoforViewController = ConstraintSvetoforViewController()
        constraintSvetoforViewController.modalPresentationStyle = .formSheet
        present(constraintSvetoforViewController, animated: true)
    }

    @IBAction private func vflButtonPressed(_ sender: UIButton) {
        let vflSvetoforViewController = VFLSvetoforViewController()
        vflSvetoforViewController.modalPresentationStyle = .formSheet
        present(vflSvetoforViewController, animated: true)
    }

    @IBAction func vflTestButtonPressed(_ sender: UIButton) {
        let vflViewController = VFLViewController()
        vflViewController.modalPresentationStyle = .formSheet
        present(vflViewController, animated: true)
    }
}
