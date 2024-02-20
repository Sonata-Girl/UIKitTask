// NewNotificationCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка для отображения новых лайков от пользователей и упоминаний
final class NewNotificationCell: UITableViewCell {
    // MARK: Types

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

    private let postImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    // MARK: Private Properties

    private var currentUser: User?
    private var newNotification: NewNotification?

    // MARK: Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHierarchy()
        setupUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        mainImageView.image = nil
        commentLabel.text = nil
        postImage.image = nil
    }

    // MARK: Public methods

    func configureCell(newNotification: NewNotification, currentUser: User) {
        self.newNotification = newNotification
        self.currentUser = currentUser

        mainImageView.image = UIImage(named: newNotification.user.avatarImage)
        setTextComment()

        guard let imagePost = newNotification.postImage else { return }
        postImage.image = UIImage(named: imagePost)
    }

    // MARK: - Private methods

    private func setupHierarchy() {
        [
            mainImageView,
            commentLabel,
            postImage
        ].forEach { contentView.addSubview($0) }
    }

    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.heightAnchor.constraint(equalToConstant: 50).isActive = true

        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            mainImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            mainImageView.widthAnchor.constraint(equalToConstant: 40),
            mainImageView.heightAnchor.constraint(equalToConstant: 40),
        ])

        NSLayoutConstraint.activate([
            commentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            commentLabel.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: 7),
            commentLabel.widthAnchor.constraint(equalToConstant: 240),
        ])

        NSLayoutConstraint.activate([
            postImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),

            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            postImage.widthAnchor.constraint(equalToConstant: 40),
            postImage.heightAnchor.constraint(equalToConstant: 40)
        ])
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
        var textComment = "\(newNotification.user.name)"
        let dateFromNotification = Date().timeIntervalSince1970 - newNotification.date.timeIntervalSince1970

        let minutes = Int(dateFromNotification / 60)
        let hours = Int(dateFromNotification / 60 / 60)
        let days = Int(dateFromNotification / 60 / 60 / 24)

        let dateString = days == .zero ? hours == .zero ? " \(minutes)м." : " \(hours)ч." : " \(days)д."

        if case .newLikeOnComment = newNotification.type {
            textComment += "\(newNotification.type.mainTextComment)"
            textComment += "\"\(newNotification.userComment ?? "")\" "
            textComment += dateString
            return (textComment, dateString)
        }

        if case .userCallYou = newNotification.type {
            textComment += "\(newNotification.type.mainTextComment)"
            textComment += "@\(currentUserName)"
            textComment += " \"\(newNotification.userComment ?? "")\""
            textComment += dateString
            return (textComment, dateString)
        }

        return (textComment, dateString)
    }
}
