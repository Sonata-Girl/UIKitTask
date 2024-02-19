// PickerViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран для показа пикера с выбором
final class PickerViewController: UIViewController {
    // MARK: Constants

    private enum Constants {
        static let titleScreen = "Размер ноги"
        static let saveButtonTitle = "Сохранить"
        static let closedButtonImage = UIImage(systemName: "xmark")
    }

    // MARK: - Visual Components

    private let mainBottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.titleScreen
        label.font = .setVerdanaBold(withSize: 16)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Constants.closedButtonImage, for: .normal)
        button.tintColor = .label
        button.addTarget(self, action: #selector(closeScreen), for: .touchUpInside)
        return button
    }()

    private lazy var picker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()

    private lazy var saveDataButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .appPink
        button.setTitle(Constants.saveButtonTitle, for: .normal)
        button.titleLabel?.font = .setVerdanaBold(withSize: 16)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowOpacity = 0.5
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(saveData), for: .touchUpInside)
        return button
    }()

    // MARK: - Public Properties

    var dataDidSavedHandler: ((_ footSize: Int) -> ())?

    // MARK: - Private Properties

    // MARK: - Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray.withAlphaComponent(0.3)
        setupHierarchy()
        setupUI()
    }

    // MARK: Private Methods

    private var pickerSource = [36, 37, 38, 39, 40]
    private var pickerValue = 0

    private func setupHierarchy() {
        view.addSubview(mainBottomView)
        [
            titleLabel,
            closeButton,
            picker,
            saveDataButton
        ].forEach { mainBottomView.addSubview($0) }
    }

    private func setupUI() {
        NSLayoutConstraint.activate([
            mainBottomView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainBottomView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(
                equalTo: mainBottomView.bottomAnchor,
                constant: 17
            ),
            mainBottomView.heightAnchor.constraint(equalToConstant: 283)
        ])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: mainBottomView.topAnchor,
                constant: 7
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: mainBottomView.leadingAnchor,
                constant: 120
            ),
            mainBottomView.trailingAnchor.constraint(
                equalTo: titleLabel.trailingAnchor,
                constant: 120
            ),
            titleLabel.heightAnchor.constraint(equalToConstant: 44)
        ])

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(
                equalTo: mainBottomView.topAnchor,
                constant: 15
            ),
            mainBottomView.trailingAnchor.constraint(
                equalTo: closeButton.trailingAnchor,
                constant: 19
            ),
            closeButton.heightAnchor.constraint(equalToConstant: 24),
            closeButton.widthAnchor.constraint(equalToConstant: 24)
        ])

        NSLayoutConstraint.activate([
            picker.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 10
            ),
            picker.leadingAnchor.constraint(
                equalTo: mainBottomView.leadingAnchor,
                constant: 10
            ),
            mainBottomView.trailingAnchor.constraint(
                equalTo: picker.trailingAnchor,
                constant: 10
            )
        ])

        NSLayoutConstraint.activate([
            saveDataButton.topAnchor.constraint(equalTo: picker.bottomAnchor, constant: 10),
            saveDataButton.leadingAnchor.constraint(
                equalTo: mainBottomView.leadingAnchor,
                constant: 62
            ),

            mainBottomView.trailingAnchor.constraint(
                equalTo: saveDataButton.trailingAnchor,
                constant: 62
            ),
            mainBottomView.bottomAnchor.constraint(
                equalTo: saveDataButton.bottomAnchor,
                constant: 30
            ),
            saveDataButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc private func closeScreen() {
        dismiss(animated: true)
    }

    @objc private func saveData() {
        dataDidSavedHandler?(pickerValue)
        dismiss(animated: true)
    }
}

// MARK: - UIPickerViewDataSource

extension PickerViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerSource.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
}

// MARK: - UIPickerViewDelegate

extension PickerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        "\(pickerSource[row])"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerValue = pickerSource[row]
    }
}
