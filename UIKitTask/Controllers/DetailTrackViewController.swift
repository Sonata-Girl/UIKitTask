// DetailTrackViewController.swift
// Copyright © RoadMap. All rights reserved.

import AVFoundation
import UIKit

/// Контроллер экрана детализации выбранного трека (storyboard ID detailTrackViewController)
class DetailTrackViewController: UIViewController {
    // MARK: - Types

    // MARK: - Constants

    // MARK: - IBOutlet

    @IBOutlet var trackName: UILabel!
    @IBOutlet var singerName: UILabel!
    @IBOutlet var trackImageView: UIImageView!

    // MARK: - Visual Components

    // MARK: - Public Properties

    // MARK: - Private Properties

    private var track: Track?

    private var player = AVPlayer()

    // MARK: - Initializers

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        print()
    }

    // MARK: - Public methods

    func configureView(track: Track) {
        self.track = track
        trackName.text = track.name
        singerName.text = track.singer
        trackImageView.image = UIImage(named: "\(track.imageName)")
    }

    // MARK: - IBAction или @objc (not private)

    // MARK: - Private Methods

    // MARK: - IBAction или @objc (private)
}
