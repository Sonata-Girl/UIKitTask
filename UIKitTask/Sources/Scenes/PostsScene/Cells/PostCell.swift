// PostCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class PostCell: UITableViewCell {
    // MARK: Types

    static var identifier: String {
        String(describing: self)
    }

    // MARK: Constants

    private enum Constants {
        static let showAllButtonTitle = "Все"
        static let likeCountTitle = "Нравится:"
        static let currentUserCommentText = "Комментировать ..."
        static let lastSeenCurrentUserText = "10 минут назад"
    }

    // MARK: Visual Components

    private let userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        return imageView
    }()

    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .setVerdanaBold(withSize: 12)
        label.textColor = .label
        return label
    }()

    private let menuButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.dotsButtonPost, for: .normal)
        button.tintColor = .label
        return button
    }()

    private lazy var scrollImagesView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self

        return scrollView
    }()

    private let imagePageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.hidesForSinglePage = true
        pageControl.currentPageIndicatorTintColor = .label
        pageControl.pageIndicatorTintColor = .systemGray4
        pageControl.backgroundStyle = .minimal
        pageControl.allowsContinuousInteraction = false
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()

    private let likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.likeButtonPost, for: .normal)
        button.tintColor = .label
        return button
    }()

    private let commentButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.commentsButtonPost, for: .normal)
        button.tintColor = .label
        return button
    }()

    private let repostButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.repostButtonPost, for: .normal)
        button.tintColor = .label
        return button
    }()

    private let bookmarkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.bookmarkButtonPost, for: .normal)
        button.tintColor = .label
        return button
    }()

    private let likesCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .setVerdanaBold(withSize: 10)
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()

    private let commentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .setVerdana(withSize: 10)
        label.textColor = .label
        label.numberOfLines = 2
        return label
    }()

    private let currentUserAvatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .gray
        return imageView
    }()

    private let currentUserCommentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .setVerdana(withSize: 10)
        label.textColor = .systemGray2
        label.text = Constants.currentUserCommentText
        return label
    }()

    private let lastSeenCurrentUserLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .setVerdana(withSize: 10)
        label.textColor = .systemGray2
        label.text = Constants.lastSeenCurrentUserText
        return label
    }()

    // MARK: Private Properties

    private var model: Post?
    private var pageImageNumber = 0

    // MARK: Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupScrollView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHierarchy()
    }

    // MARK: Public methods

    func configureView(post: Post) {
        model = post
        updateUIInScroll()
        fillCell()
    }

    // MARK: - Private methods

    override func prepareForReuse() {
        super.prepareForReuse()
        clearCellForReuse()
    }

    private func setupHierarchy() {
        [
            userImage,
            userNameLabel,
            menuButton,
            scrollImagesView,
            imagePageControl,
            likeButton,
            commentButton,
            repostButton,
            bookmarkButton,
            likesCountLabel,
            commentLabel,
            currentUserAvatarImage,
            currentUserCommentLabel,
            lastSeenCurrentUserLabel
        ].forEach { contentView.addSubview($0) }
    }

    private func setupScrollView() {
        contentView.heightAnchor.constraint(equalToConstant: 411).isActive = true
        contentView.widthAnchor.constraint(equalToConstant: 375).isActive = true

        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            userImage.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 12
            ),
            userImage.widthAnchor.constraint(equalToConstant: 30),
            userImage.heightAnchor.constraint(equalToConstant: 30)
        ])

        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            userNameLabel.leadingAnchor.constraint(
                equalTo: userImage.trailingAnchor,
                constant: 6
            ),
            userNameLabel.widthAnchor.constraint(equalToConstant: 107),
            userNameLabel.heightAnchor.constraint(equalToConstant: 30),
        ])

        NSLayoutConstraint.activate([
            menuButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            menuButton.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -5
            ),
            menuButton.widthAnchor.constraint(equalToConstant: 30),
            menuButton.heightAnchor.constraint(equalToConstant: 30)
        ])

        NSLayoutConstraint.activate([
            scrollImagesView.topAnchor.constraint(
                equalTo: userImage.bottomAnchor,
                constant: 10
            ),
            scrollImagesView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollImagesView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollImagesView.heightAnchor.constraint(equalToConstant: 239)
        ])

        NSLayoutConstraint.activate([
            likeButton.topAnchor.constraint(
                equalTo: scrollImagesView.bottomAnchor,
                constant: 8
            ),
            likeButton.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 10
            ),
            likeButton.heightAnchor.constraint(equalToConstant: 24),
            likeButton.widthAnchor.constraint(equalToConstant: 24),
        ])

        NSLayoutConstraint.activate([
            commentButton.topAnchor.constraint(
                equalTo: scrollImagesView.bottomAnchor,
                constant: 8
            ),
            commentButton.leadingAnchor.constraint(
                equalTo: likeButton.trailingAnchor,
                constant: 10
            ),
            commentButton.heightAnchor.constraint(equalToConstant: 24),
            commentButton.widthAnchor.constraint(equalToConstant: 24),
        ])

        NSLayoutConstraint.activate([
            repostButton.topAnchor.constraint(
                equalTo: scrollImagesView.bottomAnchor,
                constant: 8
            ),
            repostButton.leadingAnchor.constraint(
                equalTo: commentButton.trailingAnchor,
                constant: 10
            ),
            repostButton.heightAnchor.constraint(equalToConstant: 24),
            repostButton.widthAnchor.constraint(equalToConstant: 24),
        ])

        NSLayoutConstraint.activate([
            imagePageControl.topAnchor.constraint(
                equalTo: scrollImagesView.bottomAnchor,
                constant: 8
            ),
            imagePageControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imagePageControl.heightAnchor.constraint(equalToConstant: 24),
            imagePageControl.widthAnchor.constraint(equalToConstant: 50),
        ])

        NSLayoutConstraint.activate([
            bookmarkButton.topAnchor.constraint(
                equalTo: scrollImagesView.bottomAnchor,
                constant: 8
            ),
            bookmarkButton.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -10
            ),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 24),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 24),
        ])

        NSLayoutConstraint.activate([
            likesCountLabel.topAnchor.constraint(
                equalTo: likeButton.bottomAnchor,
                constant: 2
            ),
            likesCountLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 12
            ),
            likesCountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            likesCountLabel.heightAnchor.constraint(equalToConstant: 24),
        ])

        NSLayoutConstraint.activate([
            commentLabel.topAnchor.constraint(
                equalTo: likesCountLabel.bottomAnchor,
                constant: 2
            ),
            commentLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 12
            ),
            commentLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -12
            ),
            commentLabel.heightAnchor.constraint(equalToConstant: 25)
        ])

        NSLayoutConstraint.activate([
            currentUserAvatarImage.topAnchor.constraint(
                equalTo: commentLabel.bottomAnchor,
                constant: 4
            ),
            currentUserAvatarImage.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 12
            ),
            currentUserAvatarImage.heightAnchor.constraint(equalToConstant: 20),
            currentUserAvatarImage.widthAnchor.constraint(equalToConstant: 20),
        ])

        NSLayoutConstraint.activate([
            currentUserCommentLabel.topAnchor.constraint(
                equalTo: commentLabel.bottomAnchor,
                constant: 4
            ),
            currentUserCommentLabel.leadingAnchor.constraint(
                equalTo: currentUserAvatarImage.trailingAnchor,
                constant: 3
            ),
            currentUserCommentLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -3
            ),
            currentUserCommentLabel.heightAnchor.constraint(equalToConstant: 20),
        ])

        NSLayoutConstraint.activate([
            lastSeenCurrentUserLabel.topAnchor.constraint(
                equalTo: currentUserCommentLabel.bottomAnchor,
                constant: 2
            ),
            lastSeenCurrentUserLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 12
            ),
            lastSeenCurrentUserLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -12
            ),
            lastSeenCurrentUserLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -4
            )
        ])
    }

    private func updateUIInScroll() {
        guard let images = model?.images,
              !images.isEmpty
        else { return }

        imagePageControl.numberOfPages = images.count

        var lastStoryViewLeftAnchor = scrollImagesView.leadingAnchor

        for (index, imageName) in images.enumerated() {
            let newView = UIImageView()
            newView.translatesAutoresizingMaskIntoConstraints = false
            newView.image = UIImage(named: imageName)

            scrollImagesView.addSubview(newView)

            NSLayoutConstraint.activate([
                newView.topAnchor.constraint(equalTo: scrollImagesView.contentLayoutGuide.topAnchor),
                newView.leadingAnchor.constraint(equalTo: lastStoryViewLeftAnchor),
                newView.bottomAnchor.constraint(equalTo: scrollImagesView.contentLayoutGuide.bottomAnchor),
                newView.widthAnchor.constraint(equalTo: scrollImagesView.widthAnchor),
                newView.heightAnchor.constraint(equalTo: scrollImagesView.heightAnchor)
            ])

            if index == images.count - 1 {
                newView.trailingAnchor.constraint(equalTo: scrollImagesView.contentLayoutGuide.trailingAnchor)
                    .isActive = true
            }

            lastStoryViewLeftAnchor = newView.trailingAnchor
        }
    }

    private func fillCell() {
        guard let model else { return }
        userImage.image = UIImage(named: model.user.avatarImage)
        userNameLabel.text = model.user.name
        likesCountLabel.text = "\(Constants.likeCountTitle) \(model.likes)"
        currentUserAvatarImage.image = UIImage(named: model.user.avatarImage)
        setTextComment(model: model)
    }

    private func clearCellForReuse() {
        userImage.image = nil
        userNameLabel.text = nil
        likesCountLabel.text = nil
        currentUserAvatarImage.image = nil
        commentLabel.attributedText = nil
    }

    private func setTextComment(model: Post) {
        let text = "\(model.user.name) \(model.comment)"
        let myRange = NSRange(
            location: 0,
            length: model.user.name.count
        )
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(
            NSAttributedString.Key.font,
            value: UIFont.setVerdanaBold(withSize: 10) ?? UIFont(),
            range: myRange
        )
        commentLabel.attributedText = attributedString
    }

    private func setupDescriptionLabelText() {
        let nicknameString = "tur_v_abudabi"
        let boldFont = UIFont.setVerdanaBold(withSize: 10) ?? UIFont()
        let boldAttributes = [NSAttributedString.Key.font: boldFont]
        let nicknameBold = NSMutableAttributedString(
            string: nicknameString,
            attributes: boldAttributes as [NSAttributedString.Key: Any]
        )
        let description = "Насладитесь красотой природы. Забронировать тур в Дагестан можно уже сейчас!"
        let regularAttribute = [NSAttributedString.Key.font: UIFont.setVerdana(withSize: 10)]
        let descriptionRegular = NSAttributedString(
            string: description,
            attributes: regularAttribute as [NSAttributedString.Key: Any]
        )
        nicknameBold.append(descriptionRegular)
        commentLabel.attributedText = nicknameBold
    }
}

extension PostCell: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageImageNumber = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
        imagePageControl.currentPage = pageImageNumber
    }
}
