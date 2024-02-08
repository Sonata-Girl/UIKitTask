// MainViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// MainViewController
class MainViewController: UIViewController {
    // MARK: Constants

    private let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Начать", for: .normal)
        button.titleLabel?.font = .setVerdanaBold(withSize: 15)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .systemGreen
        button.addTarget(nil, action: #selector(startGetWord), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()

    private let titleStartWordLabel: UILabel = {
        let label = UILabel()
        label.text = "Вы ввели слово"
        label.textAlignment = .center
        label.font = .setVerdanaBold(withSize: 20)
        label.isHidden = true
        return label
    }()

    private let startWordLabel: UILabel = {
        let label = UILabel()
        label.text = "Вы не ввели слово"
        label.font = .setVerdanaBold(withSize: 20)
        label.textAlignment = .center
        label.textColor = .gray
        label.isHidden = true
        return label
    }()

    private let titleReversedWordLabel: UILabel = {
        let label = UILabel()
        label.text = "А вот что получится, если читать справа налево"
        label.font = .setVerdanaBold(withSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.isHidden = true
        return label
    }()

    private let reversedWordLabel: UILabel = {
        let label = UILabel()
        label.text = "Вы не ввели слово"
        label.font = .setVerdanaBoldItalic(withSize: 20)
        label.textAlignment = .center
        label.textColor = .gray
        label.isHidden = true
        return label
    }()

    // MARK: Private Properties

    var isWordIsEnter: Bool = false {
        didSet {
            changeScreenState()
        }
    }

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(startButton)
        view.addSubview(startWordLabel)
        view.addSubview(titleStartWordLabel)

        view.addSubview(reversedWordLabel)
        view.addSubview(titleReversedWordLabel)

        startButton.frame = .init(
            x: 30,
            y: view.bounds.height / 2,
            width: view.bounds.width - 60,
            height: view.bounds.width / 8
        )
    }

    // MARK: Private Methods

    @objc private func startGetWord() {
        showAlertGetWord()
    }

    private func changeScreenState() {
        if isWordIsEnter {
        } else {}
    }
}

extension MainViewController {
    func showAlertGetWord() {
        let alertController = UIAlertController(title: "Введите ваше слово", message: "", preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel)
        let actionOk = UIAlertAction(title: "Ок", style: .cancel) { _ in
        }

        alertController.addAction(actionCancel)
        alertController.addAction(actionOk)
        alertController.preferredAction = actionOk
        present(alertController, animated: true)
    }
}
