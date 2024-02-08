// CafeViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// CafeViewController
final class CafeViewController: UIViewController {
    // MARK: IBOutlets

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var isReservedSwitch: UISwitch!
    @IBOutlet var isUpfrontPayment: UISwitch!

    // MARK: Private Properties

    private var mail: String = ""
    private var model: GuestModel?

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
    }

    // MARK: Public Methods

    func passMailToCafeReception(mail: String) {
        self.mail = mail
    }

    // MARK: Private Methods

    @IBAction func makeBillPressed(_ sender: UIButton) {
        guard checkFillingData() else { return }

        guard let model else { return }

        let goToBillController = { [weak self] in
            guard
                let self,
                let nextViewController =
                self.storyboard?.instantiateViewController(identifier: "billScreen") as? BillViewController
            else { return }
            nextViewController.passGuestForBill(model: model)
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }

        showQuestionAlert(
            title: "Выставить чек?",
            message: "",
            defaultButtonTitle: "Чек",
            completion: goToBillController
        )
    }

    private func checkFillingData() -> Bool {
        guard let name = nameTextField.text,
              !name.isEmpty,
              !mail.isEmpty
        else {
            showDefaultAlert(title: "Упс!", message: "Пожалуйста заполните данные")
            return false
        }

        model = GuestModel(
            login: mail,
            FIO: name,
            upfrontPayment: isUpfrontPayment.isOn,
            reserved: isReservedSwitch.isOn
        )
        return true
    }

    private func setupNavigationController() {
        let font = UIFont(name: "Verdana-Bold", size: 20)
        let attributes = [NSAttributedString.Key.font: font]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key: Any]
    }
}
