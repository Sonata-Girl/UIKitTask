// PersonalDataViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран ввода персональных данных
final class PersonalDataViewController: UIViewController {
    // MARK: Constants

    private enum Constants {
        static let screenTitle = "Мои данные"
        static let namePlaceholder = "Имя"
        static let surnamePlaceholder = "Фамилия"
        static let phoneNumberPlaceholder = "Номер телефона"
        static let footSizePlaceholder = "Размер ноги"
        static let birthdayPlaceholder = "День рождения"
        static let emailPlaceholder = "Почта"
        static let saveButtonTitle = "Сохранить"
        static let backButtonImage = UIImage(systemName: "chevron.left")
    }

    // MARK: Visual Components

    private lazy var backBarButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(Constants.backButtonImage, for: .normal)
        button.tintColor = .label
        button.addTarget(self, action: #selector(goBackToPreviousScreen), for: .touchUpInside)
        return button
    }()

    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .setVerdana(withSize: 16)
        textField.placeholder = Constants.namePlaceholder
        textField.backgroundColor = .appLightGray
        textField.textColor = .label
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .go
        return textField
    }()

    private let surnameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .setVerdana(withSize: 16)
        textField.placeholder = Constants.surnamePlaceholder
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .appLightGray
        textField.textColor = .label
        textField.returnKeyType = .go
        return textField
    }()

    private let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .setVerdana(withSize: 16)
        textField.placeholder = Constants.phoneNumberPlaceholder
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .appLightGray
        textField.textColor = .label
        textField.returnKeyType = .go
        return textField
    }()

    private let footSizeTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .setVerdana(withSize: 16)
        textField.placeholder = Constants.footSizePlaceholder
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .appLightGray
        textField.textColor = .label
        textField.returnKeyType = .go
        return textField
    }()

    private let birthdayTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .setVerdana(withSize: 16)
        textField.placeholder = Constants.birthdayPlaceholder
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .appLightGray
        textField.textColor = .label
        textField.returnKeyType = .go
        return textField
    }()

    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .setVerdana(withSize: 16)
        textField.placeholder = Constants.emailPlaceholder
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .appLightGray
        textField.textColor = .label
        textField.returnKeyType = .go
        return textField
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
        button.layer.cornerCurve = .continuous
        button.layer.cornerRadius = 10
        button.isHidden = true
        button.addTarget(self, action: #selector(saveData), for: .touchUpInside)
        return button
    }()

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupTextFields()
        setupNavigationBar()
        setupHierarchy()
        setupUI()
    }

    // MARK: Private Methods

    private func setupTextFields() {
        [
            nameTextField,
            surnameTextField,
            phoneNumberTextField,
            footSizeTextField,
            birthdayTextField,
            emailTextField
        ].forEach { $0.delegate = self }

        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .inline
        birthdayTextField.inputView = datePicker
    }

    private func setupNavigationBar() {
        let leftBarItem = UIBarButtonItem(customView: backBarButton)
        navigationItem.leftBarButtonItem = leftBarItem
        navigationItem.title = Constants.screenTitle
    }

    private func setupHierarchy() {
        [
            nameTextField,
            surnameTextField,
            phoneNumberTextField,
            footSizeTextField,
            birthdayTextField,
            emailTextField,
            saveDataButton
        ].forEach { view.addSubview($0) }
    }

    private func setupUI() {
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 10
            ),
            nameTextField.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 20
            ),

            view.safeAreaLayoutGuide.trailingAnchor.constraint(
                equalTo: nameTextField.trailingAnchor,
                constant: 20
            )
        ])

        NSLayoutConstraint.activate([
            surnameTextField.topAnchor.constraint(
                equalTo: nameTextField.bottomAnchor,
                constant: 10
            ),
            surnameTextField.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 20
            ),

            view.safeAreaLayoutGuide.trailingAnchor.constraint(
                equalTo: surnameTextField.trailingAnchor,
                constant: 20
            )
        ])

        NSLayoutConstraint.activate([
            phoneNumberTextField.topAnchor.constraint(
                equalTo: surnameTextField.bottomAnchor,
                constant: 10
            ),
            phoneNumberTextField.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 20
            ),

            view.safeAreaLayoutGuide.trailingAnchor.constraint(
                equalTo: phoneNumberTextField.trailingAnchor,
                constant: 20
            )
        ])

        NSLayoutConstraint.activate([
            footSizeTextField.topAnchor.constraint(
                equalTo: phoneNumberTextField.bottomAnchor,
                constant: 10
            ),
            footSizeTextField.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 20
            ),

            view.safeAreaLayoutGuide.trailingAnchor.constraint(
                equalTo: footSizeTextField.trailingAnchor,
                constant: 20
            )
        ])

        NSLayoutConstraint.activate([
            birthdayTextField.topAnchor.constraint(
                equalTo: footSizeTextField.bottomAnchor,
                constant: 10
            ),
            birthdayTextField.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 20
            ),

            view.safeAreaLayoutGuide.trailingAnchor.constraint(
                equalTo: birthdayTextField.trailingAnchor,
                constant: 20
            )
        ])

        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(
                equalTo: birthdayTextField.bottomAnchor,
                constant: 10
            ),
            emailTextField.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 20
            ),

            view.safeAreaLayoutGuide.trailingAnchor.constraint(
                equalTo: emailTextField.trailingAnchor,
                constant: 20
            )
        ])

        NSLayoutConstraint.activate([
            saveDataButton.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 20
            ),

            view.safeAreaLayoutGuide.trailingAnchor.constraint(
                equalTo: saveDataButton.trailingAnchor,
                constant: 20
            ),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(
                equalTo: saveDataButton.bottomAnchor,
                constant: 20
            ),
            saveDataButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func changeStateOfButton() {
        saveDataButton.isHidden = false
    }

    private func showPickerWindow() {
        let pickerVC = PickerViewController()
        pickerVC.modalTransitionStyle = .crossDissolve
        pickerVC.modalPresentationStyle = .overFullScreen
        present(pickerVC, animated: true)
    }

    @objc private func goBackToPreviousScreen() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func saveData() {
        // TODO: Save data
        navigationController?.popViewController(animated: true)
    }
}

extension PersonalDataViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        changeStateOfButton()
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == footSizeTextField {
            showPickerWindow()
        }
    }
}
