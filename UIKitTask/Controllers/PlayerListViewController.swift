// PlayerListViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Стартовый экран приложений, список песен
class PlayerListViewController: UIViewController {
    // MARK: - Types

    // MARK: - Constants

    // MARK: - IBOutlet

    @IBOutlet private var trackOneView: UIView!
    @IBOutlet private var trackTwoView: UIView!
    @IBOutlet private var trackThreeView: UIView!

    // MARK: - Visual Components

    // MARK: - Public Properties

    // MARK: - Private Properties

    private var tracks: [Track] = []

    // MARK: - Initializers

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupGestures()
        getData()
    }

    // MARK: - Public methods

    // MARK: - IBAction или @objc (not private)

    // MARK: - Private Methods

    private func setupGestures() {
        let tapOne = UITapGestureRecognizer(target: self, action: #selector(trackTapped(sender:)))
        trackOneView.addGestureRecognizer(tapOne)
        let tapTwo = UITapGestureRecognizer(target: self, action: #selector(trackTapped(sender:)))
        trackTwoView.addGestureRecognizer(tapTwo)
        let tapThree = UITapGestureRecognizer(target: self, action: #selector(trackTapped(sender:)))
        trackThreeView.addGestureRecognizer(tapThree)
        trackOneView.isUserInteractionEnabled = true
        trackTwoView.isUserInteractionEnabled = true
        trackThreeView.isUserInteractionEnabled = true
    }

    private func getData() {
        tracks += [
            Track(name: "Let it be", singer: "The Beatles", imageName: "letItBe"),
            Track(name: "Yesterday", singer: "The Beatles", imageName: "yesterday"),
            Track(name: "Show must go on", singer: "Queen", imageName: "queen")
        ]
    }

    // MARK: - IBAction или @objc (private)

    @objc private func trackTapped(sender: UITapGestureRecognizer) {
        prepareAndPresentData(sender: sender)
    }

    private func prepareAndPresentData(sender: UITapGestureRecognizer) {
        guard
            let detailVC = storyboard?.instantiateViewController(identifier: "detailTrackViewController")
            as? DetailTrackViewController
        else { return }
        var track: Track?
        if sender.view == trackOneView {
            track = tracks[0]
        } else if sender.view == trackTwoView {
            track = tracks[1]
        } else if sender.view == trackThreeView {
            track = tracks[2]
        }
        guard let track else { return }

        detailVC.configureView(track: track)
        present(detailVC, animated: true)
    }
}
