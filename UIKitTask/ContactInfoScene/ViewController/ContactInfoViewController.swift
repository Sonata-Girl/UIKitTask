// ContactInfoViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран для ввода данных и добавления день рождения контакта
final class ContactInfoViewController: UIViewController {
    // MARK: Visual Components

    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = .setVerdana(withSize: 14)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(nil, action: #selector(cancelButtonPressed), for: .touchUpInside)
        return button
    }()

    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.titleLabel?.font = .setVerdana(withSize: 14)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(nil, action: #selector(addButtonPressed), for: .touchUpInside)
        return button
    }()

    private let contactImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "ContactEmpty")
        return imageView
    }()

    private let changePhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("ChangePhoto", for: .normal)
        button.titleLabel?.font = .setVerdana(withSize: 16)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()

    private lazy var nameCell: ContactInfoCellView = {
        let viewCell = ContactInfoCellView()
        viewCell.delegate = self
        viewCell.configureView(
            title: "Name Surname",
            placeholderText: "Typing Name Surname"
        )
        return viewCell
    }()

    private lazy var birthdayCell: ContactInfoCellView = {
        let viewCell = ContactInfoCellView()
        viewCell.delegate = self
        viewCell.configureView(
            title: "Birthday",
            placeholderText: "Typing Date of Birth"
        )
        return viewCell
    }()

    private lazy var ageCell: ContactInfoCellView = {
        let viewCell = ContactInfoCellView()
        viewCell.delegate = self
        viewCell.configureView(
            title: "Age",
            placeholderText: "Typing age"
        )
        return viewCell
    }()

    private lazy var genderCell: ContactInfoCellView = {
        let viewCell = ContactInfoCellView()
        viewCell.delegate = self
        viewCell.configureView(
            title: "Gender",
            placeholderText: "Typing Gender"
        )
        return viewCell
    }()

    private let telegramLabel: UILabel = {
        let label = UILabel()
        label.text = "Telegram"
        label.font = .setVerdanaBold(withSize: 16)
        label.textColor = .black
        return label
    }()

    private lazy var inputTelegramTextField: UITextField = {
        let textField = UITextField()
        textField.font = .setVerdana(withSize: 14)
        textField.placeholder = "Typing Telegram"
        textField.textColor = .label
        textField.delegate = self
        return textField
    }()

    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()

    // MARK: Public Properties

    var addContactButtonPressed: ((String, Date) -> ())?

    // MARK: Private Properties

    private var birthDay: Date?

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupUI()
        addGestures()
    }

    private func setupHierarchy() {
        [
            cancelButton,
            addButton,
            contactImage,
            changePhotoButton,
            nameCell,
            birthdayCell,
            ageCell,
            genderCell,
            telegramLabel,
            inputTelegramTextField,
            divider
        ].forEach { view.addSubview($0) }
    }

    private func setupUI() {
        view.backgroundColor = .white
        cancelButton.frame = .init(x: 20, y: 15, width: 50, height: 20)
        addButton.frame = .init(x: view.frame.size.width - 40 - 20, y: 15, width: 40, height: 20)

        contactImage.frame = .init(x: 125, y: 66, width: 125, height: 125)
        changePhotoButton.frame = .init(x: 125, y: 199, width: 125, height: 20)

        nameCell.frame = .init(x: 0, y: 229, width: 335, height: 74)
        birthdayCell.frame = .init(x: 0, y: nameCell.frame.origin.y + 74 + 10, width: 335, height: 74)
        ageCell.frame = .init(x: 0, y: birthdayCell.frame.origin.y + 74 + 10, width: 335, height: 74)
        genderCell.frame = .init(x: 0, y: ageCell.frame.origin.y + 74 + 10, width: 335, height: 74)

        telegramLabel.frame = .init(x: 20, y: genderCell.frame.origin.y + 74 + 20, width: 175, height: 19)
        inputTelegramTextField.frame = .init(
            x: 20,
            y: telegramLabel.frame.origin.y + 19 + 10,
            width: 250,
            height: 17
        )
        divider.frame = .init(
            x: 20,
            y: inputTelegramTextField.frame.origin.y + 17 + 8,
            width: 335,
            height: 1
        )
    }

    // MARK: Private Methods

    @objc private func openTelegramInput() {
        let alertController = UIAlertController(
            title: "Please enter Telegram",
            message: "",
            preferredStyle: .alert
        )

        alertController.addTextField { textField in
            textField.placeholder = "Typing Telegram"
            textField.font = .setVerdana(withSize: 14)
        }

        let actionOk = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
            if let text = alertController.textFields?.first?.text {
                self?.inputTelegramTextField.text = text
            }
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)

        alertController.addAction(actionOk)
        alertController.addAction(actionCancel)

        alertController.preferredAction = actionOk
        present(alertController, animated: true)
    }

    @objc private func addButtonPressed() {
        guard let birthDay,
              !nameCell.inputedText.isEmpty
        else { return }
        addContactButtonPressed?(nameCell.inputedText, birthDay)
        dismiss(animated: true)
    }

    @objc private func cancelButtonPressed() {
        dismiss(animated: true)
    }

    @objc private func handleTapHideKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - Setup gestures

private extension ContactInfoViewController {
    func addGestures() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapHideKeyboard)))
    }
}

// MARK: - ContactInfoCellViewDelegate

extension ContactInfoViewController: ContactInfoCellViewDelegate {
    func datePickerValueChanged(date: Date) {
        birthDay = date
    }
}

// MARK: - UITextFieldDelegate

extension ContactInfoViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == inputTelegramTextField {
            openTelegramInput()
        }
    }
}

// MARK: - UIPickerDelegate

extension ContactInfoViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case ageCell.title.hashValue:
            return "\(row + 1)"
        case genderCell.title.hashValue:
            return Gender.getValue(index: row)
        default: return nil
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case ageCell.title.hashValue:
            ageCell.setTextForCell(text: "\(row + 1)")
        case genderCell.title.hashValue:
            genderCell.setTextForCell(text: Gender(rawValue: row)?.getString() ?? "")
        default: break
        }
    }
}

// MARK: - UIPickerViewDataSource

extension ContactInfoViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case ageCell.title.hashValue:
            return 70
        case genderCell.title.hashValue:
            return 2
        default: return 0
        }
    }
}
