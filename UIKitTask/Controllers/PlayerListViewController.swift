// PlayerListViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Стартовый экран приложений, список песен
class PlayerListViewController: UIViewController {
    // MARK: - IBOutlet

    @IBOutlet private var trackOneView: UIView!
    @IBOutlet private var trackTwoView: UIView!
    @IBOutlet private var trackThreeView: UIView!
    @IBOutlet private var trackFourView: UIView!
    @IBOutlet private var trackFiveView: UIView!

    // MARK: - Private Properties

    private var tracks: [Track] = []

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupGestures()
        getData()
    }

    // MARK: - Private Methods

    private func setupGestures() {
        let tapOne = UITapGestureRecognizer(target: self, action: #selector(trackTapped(sender:)))
        trackOneView.addGestureRecognizer(tapOne)
        trackOneView.isUserInteractionEnabled = true

        let tapTwo = UITapGestureRecognizer(target: self, action: #selector(trackTapped(sender:)))
        trackTwoView.addGestureRecognizer(tapTwo)
        trackTwoView.isUserInteractionEnabled = true

        let tapThree = UITapGestureRecognizer(target: self, action: #selector(trackTapped(sender:)))
        trackThreeView.addGestureRecognizer(tapThree)
        trackThreeView.isUserInteractionEnabled = true

        let tapFour = UITapGestureRecognizer(target: self, action: #selector(trackTapped(sender:)))
        trackFourView.addGestureRecognizer(tapFour)
        trackFourView.isUserInteractionEnabled = true

        let tapFive = UITapGestureRecognizer(target: self, action: #selector(trackTapped(sender:)))
        trackFiveView.addGestureRecognizer(tapFive)
        trackFiveView.isUserInteractionEnabled = true
    }

    private func getData() {
        tracks += [
            Track(
                name: "Let it be",
                singer: "The Beatles",
                imageName: "letItBe",
                musicName: nil,
                formatAudio: nil
            ),
            Track(
                name: "Yesterday",

                singer: "The Beatles",
                imageName: "yesterday",
                musicName: nil,
                formatAudio: nil
            ),
            Track(
                name: "Show must go on",
                singer: "Queen",
                imageName: "queen",
                musicName: nil,
                formatAudio: nil
            ),
            Track(
                name: "Ever dream",
                singer: "Nightwish",
                imageName: "emptyAlbum",
                musicName: "Nightwish",
                formatAudio: "mp3"
            ),
            Track(
                name: "Pumped up Kicks",
                singer: "Dual session",
                imageName: "pumpedUpKicks",
                musicName: "Pumped up Kicks",
                formatAudio: "mp3"
            )
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
        var indexTrack = 0
        switch sender.view {
        case trackOneView:
            indexTrack = 0
        case trackTwoView:
            indexTrack = 1
        case trackThreeView:
            indexTrack = 2
        case trackFourView:
            indexTrack = 3
        case trackFiveView:
            indexTrack = 4
        default: break
        }

        detailVC.configureView(tracks: tracks, indexTrack: indexTrack)
        present(detailVC, animated: true)
    }
}
