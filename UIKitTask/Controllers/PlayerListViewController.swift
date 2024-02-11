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
        let tap = UIGestureRecognizer(target: self, action: #selector(trackTapped(sender:)))
        trackOneView.addGestureRecognizer(tap)
        trackTwoView.addGestureRecognizer(tap)
        trackThreeView.addGestureRecognizer(tap)
    }

    private func getData() {
        tracks += [
            Track(name: "Let it be", singer: "The Beatles", imageName: "letItBe"),
            Track(name: "Yestarday", singer: "The Beatles", imageName: "yestarday"),
            Track(name: "Show must go on", singer: "Queen", imageName: "queen")
        ]
    }

    // MARK: - IBAction или @objc (private)

    @objc private func trackTapped(sender: UIView) {
        prepareAndPresentData(sender: sender)
    }

    private func prepareAndPresentData(sender: UIView) {
        guard
            let detailVC = storyboard?.instantiateViewController(identifier: "detailTrackViewController")
            as? DetailTrackViewController
        else { return }
        detailVC.modalPresentationStyle = .pageSheet
        var track: Track?
        if sender == trackOneView {
            track = tracks[0]
        } else if sender == trackTwoView {
            track = tracks[1]
        } else if sender == trackThreeView {
            track = tracks[2]
        }
        guard let track else { return }
        detailVC.configureView(track: track)
        present(detailVC, animated: true)
    }
}
