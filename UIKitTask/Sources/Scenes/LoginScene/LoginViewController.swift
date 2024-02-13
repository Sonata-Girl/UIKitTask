// LoginViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Стартовый экран для авторизации в приложении
final class LoginViewController: UIViewController {
    // MARK: - Visual Components

    private let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "КофеиновЪ")
        return imageView
    }()

    private let menuWhiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()

    private let authorizationLabel: UILabel = {
        let label = UILabel()
        label.font = .setVerdanaBold(withSize: 26)
        label.textColor = .black
        label.text = "Авторизация"
        return label
    }()

    private let loginLabel: UILabel = {
        let label = UILabel()
        label.font = .setVerdanaBold(withSize: 16)
        label.textColor = .black
        label.text = "Логин"
        return label
    }()

    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.font = .setVerdana(withSize: 14)
        textField.placeholder = "Введите почту"
        textField.textColor = .label
        textField.addTarget(self, action: #selector(emailTextChanged), for: .editingChanged)
        return textField
    }()

    private let loginUnderView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()

    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.font = .setVerdanaBold(withSize: 16)
        label.textColor = .black
        label.text = "Пароль"
        return label
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.font = .setVerdana(withSize: 14)
        textField.placeholder = "Введите пароль"
        textField.textColor = .label
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(passwordTextChanged), for: .editingChanged)
        return textField
    }()

    private let passwordUnderView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()

    private lazy var showPasswordButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemGray2
        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        button.addTarget(self, action: #selector(showPasswordButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 89 / 255, green: 190 / 255, blue: 199 / 255, alpha: 0.3)
        button.setTitle("Войти", for: .normal)
        button.titleLabel?.font = .setVerdanaBold(withSize: 16)
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        button.isEnabled = false
        button.layer.cornerRadius = 12
        return button
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupUI()
    }

    // MARK: - Private Methods

    private func setupHierarchy() {
        view.addSubview(logoImage)
        view.addSubview(menuWhiteView)
        menuWhiteView.addSubview(authorizationLabel)
        menuWhiteView.addSubview(loginLabel)
        menuWhiteView.addSubview(loginTextField)
        menuWhiteView.addSubview(loginUnderView)
        menuWhiteView.addSubview(passwordLabel)
        menuWhiteView.addSubview(passwordTextField)
        menuWhiteView.addSubview(passwordUnderView)
        menuWhiteView.addSubview(showPasswordButton)
        menuWhiteView.addSubview(loginButton)
    }

    private func setupUI() {
        view.backgroundColor = UIColor(red: 120 / 255, green: 84 / 255, blue: 49 / 255, alpha: 1)
        logoImage.frame = .init(x: 100, y: 103, width: 175, height: 76)
        menuWhiteView.frame = .init(x: 0, y: 248, width: 375, height: 564)
        authorizationLabel.frame = .init(x: 20, y: 32, width: 195, height: 31)
        loginLabel.frame = .init(x: 20, y: 84, width: 175, height: 19)
        loginTextField.frame = .init(x: 20, y: 113, width: 175, height: 17)
        loginUnderView.frame = .init(x: 20, y: 138, width: 335, height: 1)
        passwordLabel.frame = .init(x: 20, y: 159, width: 175, height: 19)
        passwordTextField.frame = .init(x: 20, y: 188, width: 129, height: 17)
        passwordUnderView.frame = .init(x: 20, y: 214, width: 335, height: 1)
        showPasswordButton.frame = .init(x: 332, y: 185, width: 22, height: 19)
        loginButton.frame = .init(x: 20, y: 416, width: 335, height: 44)
    }

    private func changeStateLoginButton() {
        guard let email = loginTextField.text,
              !email.isEmpty,
              let password = passwordTextField.text,
              !password.isEmpty
        else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = UIColor(red: 89 / 255, green: 190 / 255, blue: 199 / 255, alpha: 0.3)
            return
        }
        loginButton.isEnabled = true
        loginButton.backgroundColor = UIColor(red: 89 / 255, green: 190 / 255, blue: 199 / 255, alpha: 1)
    }

    @objc private func showPasswordButtonTapped(sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        if sender.currentImage == UIImage(systemName: "eye.slash.fill") {
            sender.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        }
    }

    @objc private func loginButtonPressed() {
        dismiss(animated: true)
    }

    @objc private func emailTextChanged() {
        changeStateLoginButton()
    }

    @objc private func passwordTextChanged() {
        changeStateLoginButton()
    }
}
