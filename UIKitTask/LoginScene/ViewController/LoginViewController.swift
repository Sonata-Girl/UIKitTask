// LoginViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// ViewController
final class LoginViewController: UIViewController {
    // MARK: - Types

    // MARK: - Constants

    // MARK: - Visual Components

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.startScreenIconName)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Birthday \n Reminder"
        label.font = .setVerdanaBold(withSize: 18)
        label.numberOfLines = 2
        label.textColor = .appPurple
        label.textAlignment = .center
        return label
    }()

    private let signInLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign in"
        label.font = .setVerdanaBold(withSize: 26)
        label.textColor = .appPink
        return label
    }()

    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = .setVerdanaBold(withSize: 14)
        label.textColor = .appPink
        return label
    }()

    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.font = .setVerdana(withSize: 14)
        textField.placeholder = "Typing email"
        textField.textColor = .label
        textField.addTarget(self, action: #selector(emailTextChanged), for: .editingChanged)
        return textField
    }()

    private let mailDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()

    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = .setVerdanaBold(withSize: 14)
        label.textColor = .appPink
        return label
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.font = .setVerdana(withSize: 14)
        textField.placeholder = "Typing password"
        textField.textColor = .label
        textField.addTarget(self, action: #selector(passwordTextChanged), for: .editingChanged)
        return textField
    }()

    private lazy var showPasswordButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemGray2
        button.setTitle("Login", for: .normal)
        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        button.addTarget(self, action: #selector(showPasswordButtonTap), for: .touchUpInside)
        return button
    }()

    private let passwordDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()

    private let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .appPink
        button.alpha = 0.5
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = .setVerdanaBold(withSize: 16)
        button.isUserInteractionEnabled = false
        button.addTarget(nil, action: #selector(loginButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
    }()

    private let faceIDLabel: UILabel = {
        let label = UILabel()
        label.text = "Use FaceID"
        label.font = .setVerdanaBold(withSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    private let faceIDSwitch: UISwitch = {
        let switchElement = UISwitch()
        switchElement.isOn = true
        return switchElement
    }()

    // MARK: - Public Properties

    // MARK: - Private Properties

    // MARK: - Initializers

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupUI()
    }

    private func setupHierarchy() {
        [
            imageView,
            appNameLabel,
            signInLabel,
            emailLabel,
            emailTextField,
            mailDivider,
            passwordLabel,
            passwordTextField,
            showPasswordButton,
            passwordDivider,
            loginButton,
            faceIDLabel,
            faceIDSwitch
        ].forEach { view.addSubview($0) }
    }

    private func setupUI() {
        view.backgroundColor = .white
        imageView.frame = .init(x: 125, y: 70, width: 125, height: 125)
        appNameLabel.frame = .init(x: 100, y: 200, width: 175, height: 44)
        signInLabel.frame = .init(x: 20, y: 266, width: 175, height: 31)

        emailLabel.frame = .init(x: 20, y: 318, width: 300, height: 19)
        emailTextField.frame = .init(x: 20, y: 347, width: 300, height: 17)
        mailDivider.frame = .init(x: 20, y: 372, width: 335, height: 1)

        passwordLabel.frame = .init(x: 20, y: 393, width: 300, height: 19)
        passwordTextField.frame = .init(x: 20, y: 422, width: 300, height: 17)
        showPasswordButton.frame = .init(x: 332, y: 419, width: 22, height: 19)
        passwordDivider.frame = .init(x: 20, y: 448, width: 335, height: 1)

        faceIDLabel.frame = .init(x: 86, y: 544, width: 150, height: 35)
        faceIDSwitch.frame = .init(x: 248, y: 544, width: 54, height: 35)

        loginButton.frame = .init(x: 20, y: 671, width: 335, height: 44)
    }

    // MARK: - Public methods

    // MARK: - IBAction или @objc (not private)

    // MARK: - Private Methods

    private func changeStateLoginButton() {
        guard
            let mail = emailTextField.text,
            let password = passwordTextField.text
        else { return }
        loginButton.isUserInteractionEnabled = !mail.isEmpty && !password.isEmpty
        loginButton.alpha = loginButton.isUserInteractionEnabled ? 1 : 0.5
    }

    // MARK: - IBAction или @objc (private)

    @objc private func showPasswordButtonTap() {
        passwordTextField.isSecureTextEntry.toggle()
    }

    @objc private func emailTextChanged() {
        changeStateLoginButton()
    }

    @objc private func passwordTextChanged() {
        changeStateLoginButton()
    }

    @objc private func loginButtonPressed() {
        do {
            let emailRegex = try Regex("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
            guard
                let mail = emailTextField.text,
                mail.contains(emailRegex)
            else {
                showDefaultAlert(title: "Упс!", message: "Проверьте пожалуйста правильность ввода данных")
                return
            }
            let nextViewController = ReminderListViewController()
            navigationController?.pushViewController(nextViewController, animated: true)
        } catch {}
    }
}

// MARK: - Constants

private enum Constants {
    static let startScreenIconName = "StartScreenIcon"
}
