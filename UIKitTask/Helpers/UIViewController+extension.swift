// UIViewController+extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для универсальных алертов
extension UIViewController {
    /// Алерт для показа информации и кнопки ОК
    func showDefaultAlert(title: String, message: String?, needCancel: Bool = false) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Ок", style: .default)
        alertController.addAction(actionOk)

        if needCancel {
            let actionCancel = UIAlertAction(title: "Отмена", style: .cancel)
            alertController.addAction(actionCancel)
        }

        alertController.preferredAction = actionOk
        present(alertController, animated: true)
    }

    /// Алерт для показа информации c кнопкой ok и действием для нее
    func showQuestionAlert(
        title: String,
        message: String?,
        defaultButtonTitle: String,
        completion: @escaping () -> ()
    ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: defaultButtonTitle, style: .default) { _ in
            completion()
        }
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel)

        alertController.addAction(actionOk)
        alertController.addAction(actionCancel)

        alertController.preferredAction = actionOk
        present(alertController, animated: true)
    }
}
