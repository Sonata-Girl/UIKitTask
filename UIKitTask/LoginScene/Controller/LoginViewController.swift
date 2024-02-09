// LoginViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Стартовый контроллер экрана входа в приложение, для ввода данных авторизации
final class LoginViewController: UIViewController {
    // MARK: IBOutlets

    @IBOutlet var mailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!

    // MARK: Life Cycle

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cafeScreenSegue" {
            guard
                let mail = mailTextField.text,
                let password = passwordTextField.text,
                !password.isEmpty,
                !mail.isEmpty,
                mail.contains("@"),
                mail.contains(".")
            else {
                showDefaultAlert(title: "Упс!", message: "Проверьте пожалуйста логин и пароль")
                return
            }
            let nextViewController = segue.destination as? CafeViewController
            nextViewController?.passMailToCafeReception(mail: mail)
        }
    }

    // MARK: Public Properties

    @IBAction func showPasswordButtonTap(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }

    @IBAction func mailTextDidChanged(_ sender: UITextField) {
        changeStateLoginButton(textField: sender)
    }

    // MARK: Private Properties

    private func changeStateLoginButton(textField: UITextField) {
        var secondTextField = UITextField()
        if textField == mailTextField {
            secondTextField = passwordTextField
        } else {
            secondTextField = mailTextField
        }
        guard
            let first = secondTextField.text,
            let second = textField.text
        else { return }

        if first.isEmpty, second.isEmpty {
            loginButton.alpha = 0.5
        } else {
            loginButton.alpha = 1
        }
    }
}
