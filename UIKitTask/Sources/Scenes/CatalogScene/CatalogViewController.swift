// CatalogViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// ViewController
class CatalogViewController: UIViewController {
    private lazy var saveDataButton: UIButton = {
        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .appPink
//        button.setTitle(Constants.saveButtonTitle, for: .normal)
        button.titleLabel?.font = .setVerdanaBold(withSize: 16)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowOpacity = 0.5
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(saveData), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(saveDataButton)
        saveDataButton.center = view.center
    }

    @objc func saveData() {}
}
