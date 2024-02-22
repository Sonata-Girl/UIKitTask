// UserInfoViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка для  показа информации пользователя
final class UserInfoViewCell: UITableViewCell {
    // MARK: Constants

    private enum Constants {
        static let changeButtonTitle = "Изменить"
        static let shareButtonTitle = "Поделиться профилем"
        static let postsCountTitle = "публикации"
        static let followersCountTitle = "подписчики"
        static let subscriptionsCountTitle = "подписки"
    }

    static var identifier: String {
        String(describing: self)
    }

    // MARK: Visual Components

    private let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 40
        return imageView
    }()

    private let plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.plusMini, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .appRed
        button.isHidden = true
        button.layer.cornerRadius = 10
        return button
    }()

    private let countersContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let postsCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .setVerdanaBold(withSize: 14)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()

    private let postsCountTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .setVerdana(withSize: 10)
        label.textColor = .label
        label.textAlignment = .center
        label.text = Constants.postsCountTitle
        return label
    }()

    private let followersCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .setVerdanaBold(withSize: 14)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()

    private let followersCountTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .setVerdana(withSize: 10)
        label.textColor = .label
        label.textAlignment = .center
        label.text = Constants.followersCountTitle
        return label
    }()

    private let subscriptionsCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .setVerdanaBold(withSize: 14)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()

    private let subscriptionsCountTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .setVerdana(withSize: 10)
        label.textColor = .label
        label.textAlignment = .center
        label.text = Constants.subscriptionsCountTitle
        return label
    }()

    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .setVerdanaBold(withSize: 15)
        label.textColor = .label
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .setVerdana(withSize: 15)
        label.textColor = .label
        return label
    }()

    private lazy var linkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .setVerdana(withSize: 14)
        button.setTitleColor(.appBlue, for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(openLink), for: .touchUpInside)
        return button
    }()

    private lazy var changeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .setVerdanaBold(withSize: 10)
        button.setTitle(Constants.changeButtonTitle, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 8
        return button
    }()

    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .setVerdanaBold(withSize: 10)
        button.setTitle(Constants.shareButtonTitle, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 8
        return button
    }()

    private lazy var addUserButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.addUserButton, for: .normal)
        button.tintColor = .label
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 8
        return button
    }()

    // MARK: Public Properties

    var linkPressedHandler: ((String) -> Void)?

    // MARK: Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHierarchy()
        setupConstraints()
    }

    // MARK: Public methods

    func configureView(userPageInfo: UserPageInfo) {
        userImageView.image = UIImage(named: userPageInfo.avatarImage)
        userNameLabel.text = userPageInfo.realName
        descriptionLabel.text = userPageInfo.aboutMe
        postsCountLabel.text = "\(userPageInfo.postsCount)"
        followersCountLabel.text = "\(userPageInfo.followersCount)"
        subscriptionsCountLabel.text = "\(userPageInfo.subscriptionsCount)"
        linkButton.setTitle(userPageInfo.link, for: .normal)
//        if let url = URL(string: userPageInfo.link) {
//            linkButton.attributedText = NSAttributedString(
//                string: userPageInfo.link,
//                attributes: [NSAttributedString.Key.link: url]
//            )
//        }
    }

    // MARK: Private Methods

    private func setupHierarchy() {
        [
            topView,
            userNameLabel,
            descriptionLabel,
            linkButton,
            bottomView
        ].forEach { contentView.addSubview($0) }

        [
            postsCountLabel,
            postsCountTitleLabel,
            followersCountLabel,
            followersCountTitleLabel,
            subscriptionsCountLabel,
            subscriptionsCountTitleLabel
        ].forEach { countersContainerView.addSubview($0) }

        [
            userImageView,
            countersContainerView
        ].forEach { topView.addSubview($0) }

        userImageView.addSubview(plusButton)

        [
            changeButton,
            shareButton,
            addUserButton
        ].forEach { bottomView.addSubview($0) }
    }

    private func setupConstraints() {
        contentView.heightAnchor.constraint(equalToConstant: 230).isActive = true

        setupTopViewConstraint()
        setupUserNameLabelConstraint()
        setupDescriptionLabelConstraint()
        setupLinksLabelConstraint()
        setupBottomViewConstraint()
        setupUserImageViewConstraint()
        setupCountersContainerViewConstraint()
        setupPostsCountLabelConstraint()
        setupPostsCountTitleLabelConstraint()
        setupFollowersCountLabelConstraint()
        setupFollowersCountTitleLabelConstraint()
        setupSubscriptionsCountLabelConstraint()
        setupSubscriptionsCountTitleLabelConstraint()
        setupChangeButtonConstraint()
        setupShareButtonConstraint()
        setupAddUserButtonConstraint()
    }

    private func setupTopViewConstraint() {
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            topView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            topView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            topView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }

    private func setupUserNameLabelConstraint() {
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 5),
            userNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            userNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
        ])
    }

    private func setupDescriptionLabelConstraint() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
        ])
    }

    private func setupLinksLabelConstraint() {
        NSLayoutConstraint.activate([
            linkButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
            linkButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            linkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }

    private func setupBottomViewConstraint() {
        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: linkButton.bottomAnchor, constant: 10),
            bottomView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            bottomView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            bottomView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }

    private func setupUserImageViewConstraint() {
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: topView.topAnchor),
            userImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            userImageView.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
            userImageView.widthAnchor.constraint(equalToConstant: 80)
        ])
    }

    private func setupCountersContainerViewConstraint() {
        NSLayoutConstraint.activate([
            countersContainerView.topAnchor.constraint(equalTo: topView.topAnchor, constant: 10),
            countersContainerView.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 46),
            countersContainerView.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -23),
            countersContainerView.heightAnchor.constraint(equalToConstant: 37)
        ])
    }

    private func setupPostsCountLabelConstraint() {
        NSLayoutConstraint.activate([
            postsCountLabel.topAnchor.constraint(equalTo: countersContainerView.topAnchor),
            postsCountLabel.leadingAnchor.constraint(equalTo: countersContainerView.leadingAnchor),
            postsCountLabel.widthAnchor.constraint(equalToConstant: 70),
            postsCountLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }

    private func setupPostsCountTitleLabelConstraint() {
        NSLayoutConstraint.activate([
            postsCountTitleLabel.topAnchor.constraint(equalTo: postsCountLabel.bottomAnchor),
            postsCountTitleLabel.leadingAnchor.constraint(equalTo: countersContainerView.leadingAnchor),
            postsCountTitleLabel.widthAnchor.constraint(equalTo: postsCountLabel.widthAnchor),
            postsCountTitleLabel.bottomAnchor.constraint(equalTo: countersContainerView.bottomAnchor)
        ])
    }

    private func setupFollowersCountLabelConstraint() {
        NSLayoutConstraint.activate([
            followersCountLabel.topAnchor.constraint(equalTo: countersContainerView.topAnchor),
            followersCountLabel.leadingAnchor.constraint(equalTo: postsCountLabel.trailingAnchor),
            followersCountLabel.widthAnchor.constraint(equalTo: postsCountLabel.widthAnchor),
            followersCountLabel.heightAnchor.constraint(equalTo: postsCountLabel.heightAnchor),
        ])
    }

    private func setupFollowersCountTitleLabelConstraint() {
        NSLayoutConstraint.activate([
            followersCountTitleLabel.topAnchor.constraint(equalTo: followersCountLabel.bottomAnchor),
            followersCountTitleLabel.leadingAnchor.constraint(equalTo: postsCountLabel.trailingAnchor),
            followersCountTitleLabel.widthAnchor.constraint(equalTo: postsCountLabel.widthAnchor),
            followersCountTitleLabel.bottomAnchor.constraint(equalTo: countersContainerView.bottomAnchor)
        ])
    }

    private func setupSubscriptionsCountLabelConstraint() {
        NSLayoutConstraint.activate([
            subscriptionsCountLabel.topAnchor.constraint(equalTo: countersContainerView.topAnchor),
            subscriptionsCountLabel.leadingAnchor.constraint(equalTo: followersCountLabel.trailingAnchor),
            subscriptionsCountLabel.trailingAnchor.constraint(equalTo: countersContainerView.trailingAnchor),
            subscriptionsCountLabel.heightAnchor.constraint(equalTo: postsCountLabel.heightAnchor),
        ])
    }

    private func setupSubscriptionsCountTitleLabelConstraint() {
        NSLayoutConstraint.activate([
            subscriptionsCountTitleLabel.topAnchor.constraint(equalTo: subscriptionsCountLabel.bottomAnchor),
            subscriptionsCountTitleLabel.leadingAnchor.constraint(equalTo: followersCountLabel.trailingAnchor),
            subscriptionsCountTitleLabel.trailingAnchor.constraint(equalTo: countersContainerView.trailingAnchor),
            subscriptionsCountTitleLabel.bottomAnchor.constraint(equalTo: countersContainerView.bottomAnchor)
        ])
    }

    private func setupChangeButtonConstraint() {
        NSLayoutConstraint.activate([
            changeButton.topAnchor.constraint(equalTo: bottomView.topAnchor),
            changeButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            changeButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 155),
            changeButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor)
        ])
    }

    private func setupShareButtonConstraint() {
        NSLayoutConstraint.activate([
            shareButton.topAnchor.constraint(equalTo: bottomView.topAnchor),
            shareButton.leadingAnchor.constraint(equalTo: changeButton.trailingAnchor, constant: 5),
            shareButton.widthAnchor.constraint(greaterThanOrEqualTo: changeButton.widthAnchor),
            shareButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor)
        ])
    }

    private func setupAddUserButtonConstraint() {
        NSLayoutConstraint.activate([
            addUserButton.topAnchor.constraint(equalTo: bottomView.topAnchor),
            addUserButton.leadingAnchor.constraint(equalTo: shareButton.trailingAnchor, constant: 5),
            addUserButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            addUserButton.widthAnchor.constraint(equalToConstant: 25),
            addUserButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor)
        ])
    }

    @objc private func openLink() {
        linkPressedHandler?(linkButton.titleLabel?.text ?? "")
    }
}
