// ProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран личного кабинета, профиля
final class ProfileViewController: UIViewController {
    // MARK: Constants

    private enum Constants {
        static let screenTitle = "Профиль"
        static let userCardNumber = "1000 0001 0102"
        static let discountPercentTitle = "15%"
        static let personalDataTitle = "Личные данные"
        static let myDataTitle = "Мои данные"
        static let toTakeFriendTitle = "Приведи друга"
        static let feedBackTitle = "Обратная связь"
    }

    // MARK: - Visual Components

    private let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .label
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = .init(width: 0, height: 4)
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.25
        return view
    }()

    private let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = .cardLogo
        return imageView
    }()

    private let discountPercentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.discountPercentTitle
        label.font = .setVerdanaBold(withSize: 16)
        label.textColor = .white
        return label
    }()

    private let userCardNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.userCardNumber
        label.font = .setVerdana(withSize: 14)
        label.textColor = .white
        return label
    }()

    private let qrImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        imageView.clipsToBounds = true
        imageView.image = .qrIcon
        imageView.tintColor = .white
        imageView.backgroundColor = .gray.withAlphaComponent(0.5)
        imageView.layer.cornerRadius = 15
        return imageView
    }()

    private let infoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        imageView.image = .infoIcon
        imageView.tintColor = .white
        imageView.backgroundColor = .gray.withAlphaComponent(0.5)
        imageView.layer.cornerRadius = 15
        return imageView
    }()

    private let personalDataTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.personalDataTitle
        label.font = .setVerdanaBold(withSize: 16)
        label.textColor = .label
        return label
    }()

    private let myDataSectionIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = .myDataIcon
        return imageView
    }()

    private lazy var myDataSectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.myDataTitle
        label.font = .setVerdana(withSize: 16)
        label.textColor = .label
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(goToPersonalDataScreen))
        label.addGestureRecognizer(tap)
        return label
    }()

    private let myDataDivider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray4
        return view
    }()

    private let takeFriendSectionIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = .takeFriendIcon
        return imageView
    }()

    private let takeFriendSectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.toTakeFriendTitle
        label.font = .setVerdana(withSize: 16)
        label.textColor = .label
        return label
    }()

    private let takeFriendDivider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray4
        return view
    }()

    private let feedBackSectionIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = .feedBackIcon
        return imageView
    }()

    private let feedBackSectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.feedBackTitle
        label.font = .setVerdana(withSize: 16)
        label.textColor = .label
        return label
    }()

    private let feedBackDivider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray4
        return view
    }()

    // MARK: - Public Properties

    // MARK: - Private Properties

    var model: PersonalData?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupHierarchy()
        setupLayout()
        configureNavigationVar()
    }

    // MARK: - Public methods

    // MARK: - IBAction или @objc (not private)

    // MARK: - Private Methods

    private func setupHierarchy() {
        [
            cardView,
            personalDataTitleLabel,
            myDataSectionIcon,
            myDataSectionLabel,
            myDataDivider,
            takeFriendSectionIcon,
            takeFriendSectionLabel,
            takeFriendDivider,
            feedBackSectionIcon,
            feedBackSectionLabel,
            feedBackDivider
        ].forEach { view.addSubview($0) }

        [
            logoImage,
            discountPercentLabel,
            userCardNumberLabel,
            infoImage,
            qrImage,
        ].forEach { cardView.addSubview($0) }
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 23
            ),
            cardView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 20
            ),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(
                equalTo: cardView.trailingAnchor,
                constant: 20
            ),
            cardView.heightAnchor.constraint(equalToConstant: 180)
        ])

        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(
                equalTo: cardView.topAnchor,
                constant: 16
            ),
            logoImage.leadingAnchor.constraint(
                equalTo: cardView.leadingAnchor,
                constant: 8
            ),
            logoImage.widthAnchor.constraint(equalToConstant: 80),
            logoImage.heightAnchor.constraint(equalToConstant: 80)
        ])

        NSLayoutConstraint.activate([
            discountPercentLabel.topAnchor.constraint(
                equalTo: logoImage.bottomAnchor,
                constant: 20
            ),
            discountPercentLabel.leadingAnchor.constraint(
                equalTo: cardView.leadingAnchor,
                constant: 14
            ),
            discountPercentLabel.widthAnchor.constraint(equalToConstant: 50),
            discountPercentLabel.heightAnchor.constraint(equalToConstant: 19)
        ])

        NSLayoutConstraint.activate([
            userCardNumberLabel.topAnchor.constraint(
                equalTo: discountPercentLabel.bottomAnchor,
                constant: 7
            ),
            userCardNumberLabel.leadingAnchor.constraint(
                equalTo: cardView.leadingAnchor,
                constant: 14
            ),
            userCardNumberLabel.widthAnchor.constraint(equalToConstant: 118),
            userCardNumberLabel.heightAnchor.constraint(equalToConstant: 17)

        ])

        NSLayoutConstraint.activate([
            qrImage.topAnchor.constraint(
                equalTo: cardView.topAnchor,
                constant: 13
            ),
            cardView.trailingAnchor.constraint(
                equalTo: qrImage.trailingAnchor,
                constant: 13
            ),
            qrImage.widthAnchor.constraint(equalToConstant: 30),
            qrImage.heightAnchor.constraint(equalToConstant: 30)
        ])

        NSLayoutConstraint.activate([
            cardView.trailingAnchor.constraint(
                equalTo: infoImage.trailingAnchor,
                constant: 14
            ),
            cardView.bottomAnchor.constraint(
                equalTo: infoImage.bottomAnchor,
                constant: 20
            ),
            infoImage.widthAnchor.constraint(equalToConstant: 30),
            infoImage.heightAnchor.constraint(equalToConstant: 30)
        ])

        NSLayoutConstraint.activate([
            personalDataTitleLabel.topAnchor.constraint(
                equalTo: cardView.bottomAnchor,
                constant: 28
            ),
            personalDataTitleLabel.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 20
            ),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(
                equalTo: personalDataTitleLabel.trailingAnchor,
                constant: 20
            ),
            personalDataTitleLabel.heightAnchor.constraint(equalToConstant: 22)
        ])

        NSLayoutConstraint.activate([
            myDataSectionIcon.topAnchor.constraint(
                equalTo: personalDataTitleLabel.bottomAnchor,
                constant: 22
            ),
            myDataSectionIcon.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 22
            ),
            myDataSectionIcon.widthAnchor.constraint(equalToConstant: 18),
            myDataSectionIcon.heightAnchor.constraint(equalToConstant: 20)
        ])

        NSLayoutConstraint.activate([
            myDataSectionLabel.topAnchor.constraint(
                equalTo: personalDataTitleLabel.bottomAnchor,
                constant: 22
            ),
            myDataSectionLabel.leadingAnchor.constraint(
                equalTo: myDataSectionIcon.leadingAnchor,
                constant: 30
            ),
            myDataSectionLabel.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: 20
            ),
            myDataSectionLabel.heightAnchor.constraint(equalToConstant: 20)
        ])

        NSLayoutConstraint.activate([
            myDataDivider.topAnchor.constraint(
                equalTo: myDataSectionLabel.bottomAnchor,
                constant: 8
            ),
            myDataDivider.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 20
            ),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(
                equalTo: myDataDivider.trailingAnchor,
                constant: 20
            ),
            myDataDivider.heightAnchor.constraint(equalToConstant: 1),
        ])

        NSLayoutConstraint.activate([
            takeFriendSectionIcon.topAnchor.constraint(
                equalTo: myDataSectionLabel.bottomAnchor,
                constant: 22
            ),
            takeFriendSectionIcon.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 22
            ),
            takeFriendSectionIcon.widthAnchor.constraint(equalToConstant: 18),
            takeFriendSectionIcon.heightAnchor.constraint(equalToConstant: 20)
        ])

        NSLayoutConstraint.activate([
            takeFriendSectionLabel.topAnchor.constraint(
                equalTo: myDataSectionLabel.bottomAnchor,
                constant: 22
            ),
            takeFriendSectionLabel.leadingAnchor.constraint(
                equalTo: takeFriendSectionIcon.leadingAnchor,
                constant: 30
            ),
            takeFriendSectionLabel.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: 20
            ),
            takeFriendSectionLabel.heightAnchor.constraint(equalToConstant: 20)
        ])

        NSLayoutConstraint.activate([
            takeFriendDivider.topAnchor.constraint(
                equalTo: takeFriendSectionLabel.bottomAnchor,
                constant: 8
            ),
            takeFriendDivider.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 20
            ),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(
                equalTo: takeFriendDivider.trailingAnchor,
                constant: 20
            ),
            takeFriendDivider.heightAnchor.constraint(equalToConstant: 1),
        ])

        NSLayoutConstraint.activate([
            feedBackSectionIcon.topAnchor.constraint(
                equalTo: takeFriendSectionLabel.bottomAnchor,
                constant: 22
            ),
            feedBackSectionIcon.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 22
            ),
            feedBackSectionIcon.widthAnchor.constraint(equalToConstant: 18),
            feedBackSectionIcon.heightAnchor.constraint(equalToConstant: 20)
        ])

        NSLayoutConstraint.activate([
            feedBackSectionLabel.topAnchor.constraint(
                equalTo: takeFriendSectionLabel.bottomAnchor,
                constant: 22
            ),
            feedBackSectionLabel.leadingAnchor.constraint(
                equalTo: feedBackSectionIcon.leadingAnchor,
                constant: 30
            ),
            feedBackSectionLabel.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: 20
            ),
            feedBackSectionLabel.heightAnchor.constraint(equalToConstant: 20)
        ])

        NSLayoutConstraint.activate([
            feedBackDivider.topAnchor.constraint(
                equalTo: feedBackSectionLabel.bottomAnchor,
                constant: 8
            ),
            feedBackDivider.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 20
            ),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(
                equalTo: feedBackDivider.trailingAnchor,
                constant: 20
            ),
            feedBackDivider.heightAnchor.constraint(equalToConstant: 1),
        ])
    }

    private func configureNavigationVar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = Constants.screenTitle
    }

    @objc private func goToPersonalDataScreen() {
        let nextVC = PersonalDataViewController()
        if let model {
            nextVC.configure(model: model)
        }
        nextVC.dataDidSavedHandler = { model in
            self.model = model
        }
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
