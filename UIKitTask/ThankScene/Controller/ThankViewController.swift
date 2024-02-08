// ThankViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// ThankViewController
class ThankViewController: UIViewController {
    // MARK: IBOutlets

    @IBOutlet var mainLabel: UILabel!

    // MARK: Private Properties

    private var mail: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        mainLabel.text = "Электронный чек отправили Вам на почту \(mail)"
    }

    // MARK: Public Methods

    func passMail(mail: String) {
        self.mail = mail
    }
}
