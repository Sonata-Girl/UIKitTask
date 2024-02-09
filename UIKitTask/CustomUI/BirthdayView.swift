// BirthdayView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class BirthdayView: UIView {
    // MARK: - Visual Components

    private let contactImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 30
        return imageView
    }()

    private let contactNameLabel: UILabel = {
        let label = UILabel()
        label.font = .setVerdanaBold(withSize: 16)
        label.textColor = .label
        return label
    }()

    private let birthDateLabel: UILabel = {
        let label = UILabel()
        label.font = .setVerdana(withSize: 14)
        label.textColor = .label
        return label
    }()

    private let daysUntilBirthLabel: UILabel = {
        let label = UILabel()
        label.font = .setVerdanaBold(withSize: 16)
        label.textColor = .label
        label.isHidden = true
        return label
    }()

    private let birthdayImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "birthCake")
        imageView.clipsToBounds = false
        imageView.contentMode = .scaleAspectFill
        imageView.isHidden = true
        return imageView
    }()

    // MARK: - Private Properties

    private var isBirthDayNow: Bool = false

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHierarchy()
        setupUI()
    }

    // MARK: - Life Cycle

    private func setupHierarchy() {
        [
            contactImage,
            contactNameLabel,
            birthDateLabel,
            daysUntilBirthLabel,
            birthdayImage
        ].forEach { addSubview($0) }
    }

    private func setupUI() {
        contactImage.frame = .init(x: 20, y: 10, width: 75, height: 75)
        contactNameLabel.frame = .init(
            x: contactImage.frame.origin.x + 8,
            y: 24,
            width: 209,
            height: 20
        )
        birthDateLabel.frame = .init(
            x: contactImage.frame.origin.x + 8,
            y: contactNameLabel.frame.origin.y + 24 + 8,
            width: 209,
            height: 20
        )
    }

    private func setBirthdayIcon() {
        if isBirthDayNow {
            birthdayImage.frame = .init(
                x: frame.width - 18,
                y: birthDateLabel.frame.origin.y + birthDateLabel.frame.width + 3,
                width: 42,
                height: 44
            )
        } else {
            daysUntilBirthLabel.frame = .init(
                x: frame.width - 18,
                y: birthDateLabel.frame.origin.y + birthDateLabel.frame.width + 3,
                width: 42,
                height: 44
            )
        }
    }

    // MARK: - Public methods

    func configureView(name: String, birthday: Date) {
        contactNameLabel.text = name

        let dateFormatter = DateFormatter()
        let yearsFromBirthDay = birthday.timeIntervalSinceNow / 365 / 60 / 60 / 24
        let daysUntilBirthday = birthday.timeIntervalSinceNow / 365 / 60 / 24

        dateFormatter.dateFormat = "dd.MM"
        birthDateLabel.text = "\(dateFormatter.string(from: birthday)) - turns \(yearsFromBirthDay)"

        if daysUntilBirthday == .zero {
            isBirthDayNow = true
        } else {
            daysUntilBirthLabel.text = String(daysUntilBirthday)
        }
        setBirthdayIcon()
    }
}
