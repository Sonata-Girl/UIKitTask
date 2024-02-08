// LoginViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// LoginViewController
class LoginViewController: UIViewController {
    // MARK: - Constants

    // MARK: - IBOutlets

    @IBOutlet var mailLabel: UITextField!
    @IBOutlet var passwordLabel: UITextField!
    @IBOutlet var loginButton: UIButton!

    // MARK: - Public Properties

    // MARK: - Private Properties

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        //        configureNavigationBar()
        //        setupHierarchy()
        //        setupLayout()
        setupUI()
    }

    private func setupUI() {}

    // MARK: - Public Methods

    // MARK: - Private Methods

    @IBAction func showPasswordButtonTap(_ sender: UIButton) {
        passwordLabel.isSecureTextEntry = !passwordLabel.isSecureTextEntry
    }

    @IBAction func loginButtonTap(_ sender: UIButton) {}
}

// MARK: - Configure Navigation bar

// MARK: - Setup hierarchy

// MARK: - Setup layouts for UIElements

// MARK: - Configure view property

// MARK: - CollectionViewDataSource

// MARK: - CollectionViewDelegate

// MARK: - Collection layout methods

// MARK: - Constants
