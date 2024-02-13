// BirthdayView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class BirthdayCellView: UIView {
    // MARK: - Visual Components

    private let contactImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.cornerRadius = 40
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
        label.textColor = .appPurple
        label.isHidden = true
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()

    private let birthdayImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "BirthIdayCake")
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
            x: contactImage.frame.origin.x + 75 + 8,
            y: 24,
            width: 209,
            height: 20
        )
        birthDateLabel.frame = .init(
            x: contactImage.frame.origin.x + 75 + 8,
            y: contactNameLabel.frame.origin.y + 24 + 8,
            width: 209,
            height: 20
        )
    }

    // MARK: - Public methods

    func configureView(name: String, birthday: Date, countOfView: Int) {
        contactNameLabel.text = name

        let dateFormatter = DateFormatter()
        let yearsFromBirthDay = Int(birthday.timeIntervalSinceNow / 365 / 60 / 60 / 24) * -1
        let daysUntilBirthday = Int(birthday.timeIntervalSinceNow / 60 / 60 / 24) * -1

        dateFormatter.dateFormat = "dd.MM"
        birthDateLabel.text = "\(dateFormatter.string(from: birthday)) - turns \(yearsFromBirthDay)"

        if daysUntilBirthday == .zero {
            isBirthDayNow = true
        } else {
            daysUntilBirthLabel.text = "\(daysUntilBirthday)\n days"
        }
        setBirthdayIcon()

        contactImage.image = UIImage(named: "Contact\(countOfView)")
    }

    // MARK: - Private Properties

    private func setBirthdayIcon() {
        if isBirthDayNow {
            birthdayImage.frame = .init(
                x: frame.width - 42,
                y: 25,
                width: 42,
                height: 44
            )
            birthdayImage.isHidden = false
        } else {
            daysUntilBirthLabel.frame = .init(
                x: frame.width - 44,
                y: 25,
                width: 48,
                height: 44
            )
            daysUntilBirthLabel.isHidden = false
        }
    }
}
