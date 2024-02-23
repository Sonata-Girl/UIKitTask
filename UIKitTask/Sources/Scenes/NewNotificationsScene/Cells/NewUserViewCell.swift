// NewUserViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка для отображения новых лайков от пользователей и упоминаний
final class NewUserViewCell: UITableViewCell {
    // MARK: Constants

    private enum Constants {
        static let subscribeButtonActiveTitle = "Подписаться"
        static let subscribeButtonInactiveTitle = "Вы подписаны"
    }

    static var identifier: String {
        String(describing: self)
    }

    // MARK: Visual Components

    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        return imageView
    }()

    private let commentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .setVerdana(withSize: 12)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()

    private lazy var subscribeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .setVerdanaBold(withSize: 10)
        button.setTitle(Constants.subscribeButtonActiveTitle, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .appBlue
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.systemGray2.cgColor
        button.addTarget(self, action: #selector(subscribeButtonPressed), for: .touchUpInside)
        return button
    }()

    // MARK: Private Properties

    private var currentUser: User?
    private var newNotification: NewNotification?

    // MARK: Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        setupHierarchy()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
        setupHierarchy()
        setupConstraints()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        newNotification = nil
        currentUser = nil

        mainImageView.image = nil
        commentLabel.text = nil
        changeStateSubscribeButton()
    }

    // MARK: Public methods

    func configureCell(newNotification: NewNotification, currentUser: User) {
        self.newNotification = newNotification
        self.currentUser = currentUser

        mainImageView.image = UIImage(named: newNotification.user.avatarImage)
        setTextComment()

        changeStateSubscribeButton(subscribed: newNotification.isYouSigned)
    }

    // MARK: - Private methods

    private func configureView() {
        contentView.backgroundColor = .white
    }

    private func setupHierarchy() {
        [
            mainImageView,
            commentLabel,
            subscribeButton
        ].forEach { contentView.addSubview($0) }
    }

    private func setupConstraints() {
        contentView.heightAnchor.constraint(equalToConstant: 55).isActive = true

        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            mainImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            mainImageView.widthAnchor.constraint(equalToConstant: 40),
            mainImageView.heightAnchor.constraint(equalToConstant: 40),
        ])

        NSLayoutConstraint.activate([
            commentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            commentLabel.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: 7),
            commentLabel.widthAnchor.constraint(equalToConstant: 154),
        ])

        NSLayoutConstraint.activate([
            subscribeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            subscribeButton.leadingAnchor.constraint(equalTo: commentLabel.trailingAnchor, constant: 9),
            subscribeButton.widthAnchor.constraint(equalToConstant: 140),
            subscribeButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func changeStateSubscribeButton(subscribed: Bool = true) {
        if subscribed {
            subscribeButton.setTitle(Constants.subscribeButtonInactiveTitle, for: .normal)
            subscribeButton.setTitleColor(.systemGray2, for: .normal)
            subscribeButton.backgroundColor = .white
            subscribeButton.layer.borderWidth = 1
        } else {
            subscribeButton.setTitle(Constants.subscribeButtonActiveTitle, for: .normal)
            subscribeButton.setTitleColor(.white, for: .normal)
            subscribeButton.backgroundColor = .appBlue
            subscribeButton.layer.borderWidth = 0
        }
    }

    private func setTextComment() {
        guard
            let model = newNotification,
            let currentUser
        else { return }
        let (textCell, dateString) = getSignatureForCell(newNotification: model, currentUserName: currentUser.name)
        let userRange = NSRange(
            location: 0,
            length: model.user.name.count
        )
        let attributedString = NSMutableAttributedString(string: textCell)
        attributedString.addAttribute(
            NSAttributedString.Key.font,
            value: UIFont.setVerdanaBold(withSize: 10) ?? UIFont(),
            range: userRange
        )

        let dateRange = NSRange(
            location: textCell.count - dateString.count,
            length: dateString.count
        )
        attributedString.addAttribute(
            NSAttributedString.Key.foregroundColor,
            value: UIColor.systemGray3,
            range: dateRange
        )
        commentLabel.attributedText = attributedString
    }

    private func getSignatureForCell(newNotification: NewNotification, currentUserName: String) -> (String, String) {
        let dateFromNotification = Date().timeIntervalSince1970 - newNotification.date.timeIntervalSince1970

        let minutes = Int(dateFromNotification / 60)
        let hours = Int(dateFromNotification / 60 / 60)
        let days = Int(dateFromNotification / 60 / 60 / 24)

        let dateString = days == .zero ? hours == .zero ? " \(minutes)м." : " \(hours)ч." : " \(days)д."

        let textComment = "\(newNotification.user.name) \(newNotification.type.mainTextComment)" + dateString
        return (textComment, dateString)
    }

    @objc private func subscribeButtonPressed() {
        newNotification?.isYouSigned.toggle()
        guard let newNotification else { return }
        changeStateSubscribeButton(subscribed: newNotification.isYouSigned)
    }
}
