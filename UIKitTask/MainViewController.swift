// MainViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Стартовый экран приложения и контроллер
final class MainViewController: UIViewController {
    // MARK: Constants

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Background")
        imageView.clipsToBounds = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let greetingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Verdana-Bold", size: 30)
        label.numberOfLines = 2
        label.textColor = .white
        label.backgroundColor = UIColor.getRgbColor(151, 203, 229)
        label.textAlignment = .center
        return label
    }()

    private let guessButton: UIButton = {
        let button = UIButton()
        button.setTitle("Угадай \nчисло", for: .normal)
        button.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 20)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.getRgbColor(155, 127, 181)
        button.addTarget(nil, action: #selector(guessButtonTap), for: .touchUpInside)
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 3
        return button
    }()

    private let calculatorButton: UIButton = {
        let button = UIButton()
        button.setTitle("Калькулятор", for: .normal)
        button.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 20)
        button.backgroundColor = .systemGreen
        button.backgroundColor = UIColor.getRgbColor(100, 181, 130)
        button.addTarget(nil, action: #selector(calculatorButtonTap), for: .touchUpInside)
        button.layer.cornerRadius = 30
        button.layer.borderWidth = 3
        return button
    }()

    // MARK: Private Properties

    private var calculateResult = 0
    private var randomGuessNumber = 0

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getUserName()
    }

    private func setupUI() {
        view.addSubview(backgroundImageView)
        view.addSubview(greetingLabel)
        view.addSubview(guessButton)
        view.addSubview(calculatorButton)

        backgroundImageView.frame = view.frame

        greetingLabel.isHidden = true
        greetingLabel.frame = .init(
            x: 0,
            y: 0,
            width: view.frame.width,
            height: view.frame.width / 5
        )

        let sizeGuessButton = view.bounds.height / 6
        guessButton.frame = .init(
            x: view.bounds.width / 3.5,
            y: view.bounds.height / 3,
            width: sizeGuessButton,
            height: sizeGuessButton
        )

        let sizeCalculatorButton = view.bounds.height / 4.5
        calculatorButton.frame = .init(
            x: guessButton.frame.origin.x + 45,
            y: guessButton.frame.origin.y + guessButton.frame.height + 56,
            width: sizeCalculatorButton,
            height: sizeCalculatorButton
        )
    }

    // MARK: Private Methods

    private func getUserName() {
        showGetUserNameAlert()
    }

    private func displaceViewsFromSafeArea() {
        greetingLabel.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.greetingLabel.isHidden = false
            self.greetingLabel.frame.origin.y = self.view.safeAreaInsets.top
            self.backgroundImageView.frame.origin.y = self.view.safeAreaInsets.top
        }
    }


    @objc private func guessButtonTap() {
        randomGuessNumber = (1 ... 10).randomElement() ?? 0
        guessNumberAlert(title: "Угадайте число от 1 до 10")
    }

    @objc private func calculatorButtonTap() {
        showCalculateNumberAlert()
    }

}

// MARK: - Greeting Alert

private extension MainViewController {
    func showGetUserNameAlert() {
        let alertController = UIAlertController(
            title: "Пожалуйста, \nпредставьтесь",
            message: "",
            preferredStyle: .alert
        )
        let actionOk = UIAlertAction(title: "Готово", style: .default) { [weak self] _ in
            guard
                let userName = alertController.textFields?.first?.text,
                !userName.isEmpty
            else {
                self?.showGetUserNameAlert()
                return
            }
            self?.greetingLabel.text = " Приветствую,\n\(userName.uppercased())!"
            self?.displaceViewsFromSafeArea()
        }

        alertController.addTextField { textField in
            textField.placeholder = "Введите ваше имя"
            textField.font = .systemFont(ofSize: 18)
        }
        alertController.addAction(actionOk)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - Calculator Alerts

private extension MainViewController {
    func showCalculateNumberAlert() {
        let alertController = UIAlertController(
            title: "Введите ваши числа",
            message: "",
            preferredStyle: .alert
        )
        let actionChooseOperation = UIAlertAction(title: "Выбрать операцию", style: .default) { [weak self] _ in
            guard
                let firstNumber = Int(alertController.textFields?.first?.text ?? ""),
                let secondNumber = Int(alertController.textFields?.last?.text ?? "")
            else {
                self?.showCalculateNumberAlert()
                return
            }

            if firstNumber == .zero, secondNumber == .zero {
                self?.showCalculateNumberAlert()
                return
            }
            self?.chooseOperationAlert(numbers: [firstNumber, secondNumber])
        }

        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel)

        alertController.addTextField { textField in
            textField.placeholder = "Число 1"
            textField.keyboardType = .numberPad
        }
        alertController.addTextField { textField in
            textField.keyboardType = .numberPad
            textField.placeholder = "Число 2"
        }

        alertController.addAction(actionChooseOperation)
        alertController.addAction(actionCancel)
        alertController.preferredAction = actionChooseOperation
        present(alertController, animated: true, completion: nil)
    }

    func chooseOperationAlert(numbers: [Int]) {
        guard
            let firstNumber = numbers.first,
            let secondNumber = numbers.last
        else { return }

        enum CalculateOperations {
            case composition, subtraction, multiplication, division
        }

        let alertController = UIAlertController(
            title: "Выберите математическую операцию",
            message: "",
            preferredStyle: .alert
        )

        let calculateOperation = { (operation: CalculateOperations) -> Int in
            guard !numbers.isEmpty else { return 0 }
            if operation == .division, numbers.first == 0 {
                return 0
            }
            switch operation {
            case .composition:
                return numbers.reduce(0, +)
            case .division:
                return firstNumber / secondNumber
            case .multiplication:
                return numbers.reduce(1, *)
            case .subtraction:
                return firstNumber - secondNumber
            }
        }

        let actionComposition = UIAlertAction(title: "Сложить", style: .default) { [weak self] _ in
            self?.calculateResult = calculateOperation(.composition)
            self?.showCalculateResult()
        }
        let actionSubtraction = UIAlertAction(title: "Вычесть", style: .default) { [weak self] _ in
            self?.calculateResult = calculateOperation(.subtraction)
            self?.showCalculateResult()
        }
        let actionMultiplication = UIAlertAction(title: "Умножить", style: .default) { [weak self] _ in
            self?.calculateResult = calculateOperation(.multiplication)
            self?.showCalculateResult()
        }
        let actionDivision = UIAlertAction(title: "Разделить", style: .default) { [weak self] _ in
            self?.calculateResult = calculateOperation(.division)
            self?.showCalculateResult()
        }

        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel)

        [
            actionComposition,
            actionSubtraction,
            actionMultiplication,
            actionDivision,
            actionCancel
        ].forEach { alertController.addAction($0) }
        present(alertController, animated: true, completion: nil)
    }

    func showCalculateResult() {
        let alertController = UIAlertController(
            title: "Ваш результат",
            message: "\(calculateResult)",
            preferredStyle: .alert
        )
        let actionCancel = UIAlertAction(title: "Отмена", style: .default)
        let actionOk = UIAlertAction(title: "Ок", style: .default)

        alertController.addAction(actionCancel)
        alertController.addAction(actionOk)
        alertController.preferredAction = actionOk
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - GuessNumberGame Alerts

private extension MainViewController {
    func guessNumberAlert(title: String, message: String? = nil) {
        showDefaultButtonAlert(
            title: title,
            message: message, countButton: 2
        ) { [weak self] alertController in
            guard let number = Int(alertController.textFields?.first?.text ?? "") else { return }

            switch number {
            case ...0:
                self?.guessNumberAlert(title: "Попробуйте еще раз", message: "Вы ввели слишком маленькое число")
            case 10...:
                self?.guessNumberAlert(title: "Попробуйте еще раз", message: "Вы ввели слишком большое число")
            case 0 ... 10 where number != self?.randomGuessNumber:
                self?.showDefaultButtonAlert(title: "Упс!", message: "Это неверный ответ") { _ in }
            case 0 ... 10 where number == self?.randomGuessNumber:
                self?.showDefaultButtonAlert(title: "Поздравляем!", message: "Вы угадали") { _ in }
            default: break
            }
        }
    }

    func showDefaultButtonAlert(
        title: String,
        message: String?,
        countButton: Int = 1,
        completion: @escaping (UIAlertController) -> ()?
    ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Ок", style: .default) { _ in
            completion(alertController)
        }

        alertController.addAction(actionOk)
        if countButton > 1 {
            alertController.addTextField { textField in
                textField.placeholder = "Введите число"
                textField.keyboardType = .numberPad
            }

            let actionCancel = UIAlertAction(title: "Отмена", style: .cancel)
            alertController.addAction(actionCancel)
        }
        alertController.preferredAction = actionOk
        present(alertController, animated: true, completion: nil)
    }
}
