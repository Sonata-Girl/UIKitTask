// ContactInfoCellView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol ContactInfoCellViewDelegate: AnyObject {
    func datePickerValueChanged(date: Date)
}

/// Варианты гендеров контактов
enum Gender: Int {
    case male = 0, female = 1

    func getString() -> String {
        switch self {
        case .male:
            "Male"
        case .female:
            "Female"
        }
    }

    static func getValue(index: Int) -> String {
        if index == .zero {
            return "Male"
        } else {
            return "Female"
        }
    }
}

final class ContactInfoCellView: UIView {
    // MARK: Types

    enum TypeInputField {
        case text
        case picker
        case datePicker
    }

    // MARK: Constants

    private let formatter = DateFormatter()

    // MARK: Public Properties

    var delegate: ContactInfoViewController?
    var title: String {
        titleLabel.text ?? ""
    }

    var inputedText: String {
        inputTextField.text ?? ""
    }

    // MARK: Visual Components

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = .setVerdanaBold(withSize: 16)
        label.textColor = .black
        return label
    }()

    private lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.font = .setVerdana(withSize: 14)
        textField.placeholder = "Typing "
        textField.textColor = .label
        return textField
    }()

    private lazy var picker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()

    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        var oneYearTime: TimeInterval = 365 * 24 * 60 * 60
        let todayDate = Date()
        datePicker.minimumDate = Date().addingTimeInterval(-(oneYearTime * 70))
        datePicker.maximumDate = Date()

        return datePicker
    }()

    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()

    // MARK: - Private Properties

    var inputFieldType: TypeInputField = .text

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHierarchy()
        setupUI()
    }

    // MARK: - Life Cycle

    private func setupHierarchy() {
        [
            titleLabel,
            inputTextField,
            divider
        ].forEach { addSubview($0) }
    }

    private func setupUI() {
        titleLabel.frame = .init(x: 20, y: 10, width: 175, height: 20)
        inputTextField.frame = .init(
            x: 20,
            y: titleLabel.frame.origin.y + titleLabel.frame.height + 10,
            width: 175,
            height: 20
        )
        divider.frame = .init(
            x: 20,
            y: inputTextField.frame.origin.y + inputTextField.frame.height + 8,
            width: 335,
            height: 1
        )
    }

    // MARK: - Public methods

    func setTextForCell(text: String) {
        inputTextField.text = text
    }

    func configureView(
        title: String,
        placeholderText: String,
        titleColor: UIColor = .black
    ) {
        inputTextField.delegate = delegate
        switch title {
        case "Name Surname":
            configureTextTypeField(title: title, placeholderText: placeholderText)
        case "Telegram":
            break
        case "Birthday":
            configureDatePicker(title: title, placeholderText: placeholderText)
        default:
            configurePicker(title: title, placeholderText: placeholderText)
        }
    }

    // MARK: Private methods

    private func configureTextTypeField(
        title: String,
        placeholderText: String,
        titleColor: UIColor = .black
    ) {
        titleLabel.text = title
        inputTextField.placeholder = placeholderText

        titleLabel.textColor = titleColor
    }

    private func configurePicker(
        title: String,
        placeholderText: String
    ) {
        titleLabel.text = title
        inputTextField.placeholder = placeholderText

        createPickerView()
    }

    private func createPickerView() {
        inputTextField.inputView = picker
        inputTextField.inputView?.backgroundColor = .white
        inputTextField.inputAccessoryView = createToolbarForInputView()

        picker.delegate = delegate
        picker.dataSource = delegate

        picker.tag = title.hashValue
    }

    private func configureDatePicker(
        title: String,
        placeholderText: String
    ) {
        titleLabel.text = title
        inputTextField.placeholder = placeholderText

        inputTextField.inputView = datePicker
        inputTextField.inputView?.backgroundColor = .white
        let toolbar = createToolbarForInputView()
        if let buttonToolbar = toolbar.items?.last {
            buttonToolbar.action = #selector(saveValueFromDatePicker)
        }
        inputTextField.inputAccessoryView = toolbar
        datePicker.tag = title.hashValue
    }

    private func createToolbarForInputView() -> UIToolbar {
        let spaceButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        let okButton = UIBarButtonItem(
            title: "Ok",
            style: .done,
            target: self,
            action: #selector(closeToolbarFromTextField)
        )

        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.sizeToFit()
        toolBar.setItems([spaceButton, okButton], animated: false)
        return toolBar
    }

    @objc private func saveValueFromDatePicker() {
        formatter.dateFormat = "dd MMMM yyyy"
        inputTextField.text = formatter.string(from: datePicker.date)
        delegate?.datePickerValueChanged(date: datePicker.date)
        inputTextField.resignFirstResponder()
    }

    @objc private func closeToolbarFromTextField() {
        inputTextField.resignFirstResponder()
    }
}
