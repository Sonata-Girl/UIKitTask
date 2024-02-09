// BillViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Контроллер экрана показа заказа и вопроса отправки чека на почту, следует за экраном CafeVC
final class BillViewController: UIViewController {
    // MARK: Private Properties

    private var model: Guest?

    // MARK: Private Methods

    @IBAction func totalButtonPressed(_ sender: UIButton) {
        guard let model else { return }

        let goToThankController = { [weak self] in
            guard
                let self,
                let nextViewController =
                self.storyboard?.instantiateViewController(withIdentifier: "thankScreen") as? ThankViewController
            else { return }
            nextViewController.passMail(mail: model.login)
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }

        showQuestionAlert(
            title: "Выставить чек?",
            message: "",
            defaultButtonTitle: "Да",
            completion: goToThankController
        )
    }

    // MARK: Public Methods

    func passGuestForBill(model: Guest) {
        self.model = model
    }
}
