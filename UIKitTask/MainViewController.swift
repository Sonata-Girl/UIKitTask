// MainViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// MainViewController
class MainViewController: UIViewController {
    // MARK: Constants

    private let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Начать", for: .normal)
        button.titleLabel?.font = .setVerdanaBold(withSize: 16)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .getRgbColor(76, 216, 102)
        button.addTarget(nil, action: #selector(startGetWord), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()

    private let titleStartWordLabel: UILabel = {
        let label = UILabel()
        label.text = "Вы ввели слово"
        label.textAlignment = .center
        label.font = .setVerdanaBold(withSize: 16)
        label.isHidden = true
        return label
    }()

    private let startWordLabel: UILabel = {
        let label = UILabel()
        label.text = "Вы не ввели слово"
        label.font = .setVerdanaBoldItalic(withSize: 16)
        label.textAlignment = .center
        label.textColor = .lightGray
        label.isHidden = true
        return label
    }()

    private let titleReversedWordLabel: UILabel = {
        let label = UILabel()
        label.text = "А вот что получится, если \nчитать справа налево"
        label.font = .setVerdanaBold(withSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.isHidden = true
        return label
    }()

    private let reversedWordLabel: UILabel = {
        let label = UILabel()
        label.text = "Вы не ввели слово"
        label.font = .setVerdanaBoldItalic(withSize: 16)
        label.textAlignment = .center
        label.textColor = .lightGray
        label.isHidden = true
        return label
    }()

    // MARK: Private Properties

    var model = WordModel(word: "") {
        didSet {
            reversedWordLabel.text = model.word
            startWordLabel.text = model.reversedWord
        }
    }

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
            x: view.bounds.width / 15,
            y: view.bounds.height / 2,
            width: view.bounds.width - ((view.bounds.width / 15) * 2),
            height: view.bounds.width / 8
        )

        titleStartWordLabel.frame = .init(
            x: view.bounds.width / 13,
            y: view.bounds.height / 6,
            width: view.bounds.width - ((view.bounds.width / 13) * 2),
            height: view.bounds.width / 7
        )

        startWordLabel.frame = .init(
            x: view.bounds.width / 15,
            y: titleStartWordLabel.frame.origin.y + titleStartWordLabel.frame.height,
            width: view.bounds.width - ((view.bounds.width / 15) * 2),
            height: view.bounds.width / 7
        )

        titleReversedWordLabel.frame = .init(
            x: view.bounds.width / 15,
            y: startWordLabel.frame.origin.y + (startWordLabel.frame.height * 2),
            width: view.bounds.width - ((view.bounds.width / 15) * 2),
            height: view.bounds.width / 7
        )

        reversedWordLabel.frame = .init(
            x: view.bounds.width / 15,
            y: titleReversedWordLabel.frame.origin.y + titleReversedWordLabel.frame.height,
            width: view.bounds.width - ((view.bounds.width / 15) * 2),
            height: view.bounds.width / 7
        )
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupUI()
    }

    // MARK: Private Methods

    @objc private func startGetWord() {
        showAlertGetWord()
    }

    private func changeScreenState() {
        if isWordIsEnter {
            startButton.frame.origin.y = (view.bounds.height / 2) + (view.bounds.height / 4)

            [
                titleStartWordLabel,
                startWordLabel,
                titleReversedWordLabel,
                reversedWordLabel
            ].forEach { $0.isHidden = false }
        } else {
            startButton.frame.origin.y = view.bounds.height / 2
        }
    }
}

extension MainViewController {
    func showAlertGetWord() {
        let alertController = UIAlertController(title: "Введите ваше слово", message: "", preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel)
        let actionOk = UIAlertAction(title: "Ок", style: .default) { [weak self] _ in
            guard let wordText = alertController.textFields?.first?.text else {
                self?.showAlertGetWord()
                return
            }

            self?.model.word = wordText
            self?.isWordIsEnter = true
        }

        alertController.addTextField { textField in
            textField.placeholder = "Введите слово"
        }

        alertController.addAction(actionCancel)
        alertController.addAction(actionOk)
        alertController.preferredAction = actionOk
        present(alertController, animated: true)
    }
}
