// ReminderListViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Главный экран приложения, список день рождений контактов
final class ReminderListViewController: UIViewController {
    // MARK: - Visual Components

    // MARK: - Public Properties

    // MARK: - Private Properties

    private var lastViewYOrigin: CGFloat = 35
    private var viewHeight: CGFloat = 75
    private var contactImageNumber = 1

    // MARK: - Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
    }

    // MARK: - Life Cycle

    // MARK: - Public methods

    // MARK: - IBAction или @objc (not private)

    // MARK: - Private Methods

    @objc private func addNewContactBirthday() {
        let addContactViewController = ContactInfoViewController()
        addContactViewController.modalPresentationStyle = .pageSheet
        let addContactAction = { (name: String, birthDay: Date) in
            self.createAndAddNewContact(name: name, birthDay: birthDay)
        }
        addContactViewController.addContactButtonPressed = addContactAction
        navigationController?.present(addContactViewController, animated: true)
    }

    private func createAndAddNewContact(name: String, birthDay: Date) {
        let newView = BirthdayCellView(frame: .init(
            x: view.safeAreaInsets.left,
            y: lastViewYOrigin + viewHeight,
            width: 335,
            height: viewHeight
        ))
        lastViewYOrigin += viewHeight + 10
        newView.configureView(name: name, birthday: birthDay, countOfView: contactImageNumber)

        contactImageNumber = contactImageNumber == 4 ? 1 : contactImageNumber + 1
        view.addSubview(newView)
    }
}

// MARK: - Configure Navigation bar

private extension ReminderListViewController {
    func configureNavigationBar() {
        let font = UIFont.setVerdanaBold(withSize: 18)
        let attributes = [NSAttributedString.Key.font: font]
        navigationItem.title = "Birthday Reminder"
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key: Any]

        setupRightBarButtonItem()
    }

    func setupRightBarButtonItem() {
        let addButton = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(addNewContactBirthday)
        )

        navigationItem.rightBarButtonItem = addButton
    }
}
