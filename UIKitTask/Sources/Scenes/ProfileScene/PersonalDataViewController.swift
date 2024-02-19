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
        textField.keyboardType = .numberPad
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

    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        var oneYearTime: TimeInterval = 365 * 24 * 60 * 60
        let todayDate = Date()
        datePicker.minimumDate = Date().addingTimeInterval(-(oneYearTime * 70))
        datePicker.maximumDate = Date()
        datePicker.preferredDatePickerStyle = .inline
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)

        return datePicker
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

    // MARK: Public Properties

    var dataDidSavedHandler: ((PersonalData) -> ())?

    // MARK: Private Properties

    private var model: PersonalData?
    private let formatter = DateFormatter()
    private let maxSymbolsPhoneNumber = 11
    private let phoneNumberRegex = try? NSRegularExpression(
        pattern: "[\\+\\s-\\(\\)]",
        options: .caseInsensitive
    )

    private var phoneNumberNotFormat: String = ""

    private let emailRegex = try? NSRegularExpression(
        pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}",
        options: .caseInsensitive
    )

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupTextFields()
        setupNavigationBar()
        setupHierarchy()
        setupUI()
    }

    // MARK: Public Methods

    func configure(model: PersonalData) {
        self.model = model
        nameTextField.text = model.name
        surnameTextField.text = model.surname
        phoneNumberTextField.text = model.phoneNumber
        footSizeTextField.text = String(model.sizeFoot)
        birthdayTextField.text = model.birthday
        emailTextField.text = model.mail
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
            ),
            footSizeTextField.heightAnchor.constraint(equalToConstant: 36)
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
        pickerVC.dataDidSavedHandler = { [weak self] footSize in
            self?.footSizeTextField.text = String("\(footSize)")
        }
        present(pickerVC, animated: true)
    }

    func formatPhoneNumberWithRegex(phoneNumber: String, removeLastDigit: Bool) -> String {
        guard
            let phoneNumberRegex,
            !(
                removeLastDigit &&
                    phoneNumber.count <= 2
            )
        else { return "+" }
        let range = NSString(string: phoneNumber).range(of: phoneNumber)
        var number = phoneNumberRegex.stringByReplacingMatches(
            in: phoneNumber,
            options: [],
            range: range,
            withTemplate: ""
        )
        if number.count > maxSymbolsPhoneNumber {
            let maxIndex = number.index(number.startIndex, offsetBy: number.count - 1)
            number = String(number[number.startIndex ..< maxIndex])
        }

        if removeLastDigit {
            let maxIndex = number.index(number.startIndex, offsetBy: number.count - 1)
            number = String(number[number.startIndex ..< maxIndex])
        }

        let maxIndex = number.index(number.startIndex, offsetBy: number.count)
        let regRange = number.startIndex ..< maxIndex

        if number.count < 7 {
            let pattern = "(\\d)(\\d{3})(\\d+)"
            number = number.replacingOccurrences(
                of: pattern,
                with: "$1 ($2) $3",
                options: .regularExpression,
                range: regRange
            )
        } else {
            let pattern = "(\\d)(\\d{3})(\\d{3})(\\d{2})(\\d+)"
            number = number.replacingOccurrences(
                of: pattern,
                with: "$1 ($2) $3-$4-$5",
                options: .regularExpression,
                range: regRange
            )
        }

        return "+" + number
    }

    func formatPhoneNumber(phoneNumber: String, removeLastDigit: Bool) -> String {
        var numbers: [String] = phoneNumber.replacingOccurrences(of: " ", with: "")
            .filter { !["+", "(", ")", "-", " "].contains($0) }
            .map { String($0) }
        guard !(numbers.count == .zero) else { return "" }
        if removeLastDigit {
            numbers.removeLast()
        }

        numbers.insert("+", at: 0)
        switch numbers.count - 1 {
        case 0:
            numbers += [" (", "   ) ", "   -", "  -  "]
        case 1:
            numbers.insert("(", at: 2)
            numbers += ["   ) ", "   -", "  -  "]
        case 2:
            numbers.insert("(", at: 2)
            numbers += ["  ) ", "   -", "  -  "]
        case 3:
            numbers.insert("(", at: 2)
            numbers += [" ) ", "   -", "  -  "]
        case 4:
            numbers.insert("(", at: 2)
            numbers.insert(") ", at: 6)
            numbers += ["   -", "  -  "]
        case 5:
            numbers.insert("(", at: 2)
            numbers.insert(") ", at: 6)
            numbers += ["  -", "  -  "]
        case 6:
            numbers.insert("(", at: 2)
            numbers.insert(") ", at: 6)
            numbers += [" -", "  -  "]
        case 7:
            numbers.insert("(", at: 2)
            numbers.insert(") ", at: 6)
            numbers.insert("-", at: 10)
            numbers += ["  -  "]
        case 8:
            numbers.insert("(", at: 2)
            numbers.insert(") ", at: 6)
            numbers.insert("-", at: 10)
            numbers += [" -  "]
        case 9:
            numbers.insert("(", at: 2)
            numbers.insert(") ", at: 6)
            numbers.insert("-", at: 10)
            numbers.insert("-", at: 13)
            numbers += [" "]
        case 10:
            numbers.insert("(", at: 2)
            numbers.insert(") ", at: 6)
            numbers.insert("-", at: 10)
            numbers.insert("-", at: 13)
            numbers += [" "]
        case 11:
            numbers.insert("(", at: 2)
            numbers.insert(") ", at: 6)
            numbers.insert("-", at: 10)
            numbers.insert("-", at: 13)
        default: return phoneNumber.map { String($0) }.dropLast().joined(separator: "")
        }
        return numbers.joined(separator: "")
    }

    @objc private func datePickerValueChanged(sender: UIDatePicker) {
        if sender.isEqual(datePicker) {
            formatter.dateFormat = "dd.MM.yyyy"
            birthdayTextField.text = formatter.string(from: datePicker.date)
            birthdayTextField.resignFirstResponder()
        }
    }

    @objc private func goBackToPreviousScreen() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func saveData() {
        // TODO: Save data
        model = PersonalData(
            name: nameTextField.text ?? "",
            surname: surnameTextField.text ?? "",
            phoneNumber: phoneNumberTextField.text ?? "",
            sizeFoot: Int(footSizeTextField.text ?? "") ?? 0,
            birthday: birthdayTextField.text ?? "",
            mail: emailTextField.text ?? ""
        )
        guard let model else { return }
        dataDidSavedHandler?(model)
        navigationController?.popViewController(animated: true)
    }

    @objc private func openPickerController() {
        showPickerWindow()
    }
}

// MARK: - UITextFieldDelegate

extension PersonalDataViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        changeStateOfButton()
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.isEqual(footSizeTextField) {
            textField.resignFirstResponder()
            showPickerWindow()
        }
    }

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        if textField.isEqual(phoneNumberTextField) {
            let fullString = (textField.text ?? "") + string
            textField.text = formatPhoneNumber(phoneNumber: fullString, removeLastDigit: range.length == 1)
            return false
        }
        return true
    }
}
