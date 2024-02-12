// DetailTrackViewController.swift
// Copyright © RoadMap. All rights reserved.

import AVFoundation
import UIKit

/// Контроллер экрана детализации выбранного трека (storyboard ID detailTrackViewController)
class DetailTrackViewController: UIViewController {
    // MARK: - IBOutlet

    @IBOutlet private var trackName: UILabel!
    @IBOutlet private var singerName: UILabel!
    @IBOutlet private var trackImageView: UIImageView!
    @IBOutlet private var pauseButton: UIButton!
    @IBOutlet private var trackContinuousSlider: UISlider!
    @IBOutlet private var volumeSlider: UISlider!
    @IBOutlet private var volumeOffButton: UIButton!
    @IBOutlet var durationLabel: UILabel!

    // MARK: - Private Properties

    private var displayLink: CADisplayLink?

    private var tracks: [Track]?
    private var track: Track?
    private var currentTrack = 0
    private var lastVolume: Float = 0.3
    private var currentVolume: Float = 0.3

    private var player = AVAudioPlayer()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        trackImageView.layer.borderColor = UIColor.white.cgColor
        setupUI()
        configureUIFromData()
        activateAudioPlayer()
    }

    private func setupUI() {
        trackContinuousSlider.setThumbImage(UIImage(named: "sliderButton"), for: .normal)
        trackContinuousSlider.setMaximumTrackImage(UIImage(named: "emptyTimeSliderStripe"), for: .normal)
        trackContinuousSlider.setMinimumTrackImage(UIImage(named: "fullTimeSliderStripe"), for: .normal)

        volumeSlider.setThumbImage(UIImage(named: "sliderButton"), for: .normal)
        volumeSlider.setMaximumTrackImage(UIImage(named: "emptyTimeSliderStripe"), for: .normal)
        volumeSlider.setMinimumTrackImage(UIImage(named: "fullTimeSliderStripe"), for: .normal)

        volumeSlider.transform = volumeSlider.transform.rotated(by: CGFloat(0.5 * -Float.pi))
        volumeSlider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))

        volumeSlider.frame = CGRect(x: 8, y: 200, width: 40, height: 100) // Изменение ширины и высоты
    }

    private func configureUIFromData() {
        guard let track else { return }
        trackName.text = track.name
        singerName.text = track.singer
        trackImageView.image = UIImage(named: "\(track.imageName)")
    }

    // MARK: - Public methods

    func configureView(tracks: [Track], indexTrack: Int) {
        self.tracks = tracks
        track = tracks[indexTrack]
        currentTrack = indexTrack
    }

    // MARK: - Private Methods

    private func activateAudioPlayer() {
        do {
            if let audioPath = Bundle.main.path(forResource: track?.musicName, ofType: track?.formatAudio) {
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))

                setupStartPositionOfPlayer()
                setupDisplayLinkForUpdateSlider()

                player.play()
            }
        } catch {
            print("Error")
        }
    }

    private func setupStartPositionOfPlayer() {
        trackContinuousSlider.maximumValue = Float(player.duration)
        player.volume = currentVolume
        volumeSlider.value = currentVolume

        updateTimeLabel()
    }

    private func setupDisplayLinkForUpdateSlider() {
        let displayLink = CADisplayLink(target: self, selector: #selector(updatePlaybackStatus))
        displayLink.add(to: .main, forMode: .common)
    }

    private func setupNextTrack() {
        guard let tracks, !tracks.isEmpty else { return }
        player.stop()
        displayLink?.invalidate()

        if currentTrack == tracks.count - 1 {
            currentTrack = 0
        } else {
            currentTrack += 1
        }
        track = tracks[currentTrack]
        activateAudioPlayer()
        configureUIFromData()
    }

    private func setupPreviousTrack() {
        guard let tracks, !tracks.isEmpty else { return }
        player.stop()
        displayLink?.invalidate()

        if currentTrack == 0 {
            currentTrack = tracks.count - 1
        } else {
            currentTrack -= 1
        }
        track = tracks[currentTrack]
        activateAudioPlayer()
        configureUIFromData()
    }

    private func updateTimeLabel() {
        let trackTimeProgress = getCurrentTimePlayback()
        let timeMinutes = Int(trackTimeProgress / 60)
        let timeSeconds = Int(trackTimeProgress) % 60 * -1
        durationLabel.text = String(format: "%02d:%02d", timeMinutes, timeSeconds)
    }

    private func getCurrentTimePlayback() -> Float {
        var trackTimeProgress: Float = 0
        if player.currentTime.isZero {
            trackTimeProgress = Float(player.currentTime)
        } else {
            trackTimeProgress = Float(player.currentTime - player.duration)
        }

        return trackTimeProgress
    }

    private func changeStatePauseButton() {
        if player.isPlaying {
            pauseButton.setImage(Constants.pauseImage, for: .normal)
        } else {
            pauseButton.setImage(Constants.playImage, for: .normal)
        }
    }

    private func showAlert() {
        let alertController = UIAlertController(
            title: "Упс!",
            message: "Функционал в разработке",
            preferredStyle: .actionSheet
        )
        let action = UIAlertAction(title: "Ок", style: .default) { _ in
        }
        alertController.addAction(action)
        present(alertController, animated: true)
    }

    private func changeStateOffVolumeButton() {
        if currentVolume.isZero {
            volumeOffButton.setImage(Constants.offVolumeImage, for: .normal)
        } else {
            volumeOffButton.setImage(Constants.onVolumeImage, for: .normal)
        }
    }

    @objc private func updatePlaybackStatus() {
        let trackTimeProgress = Float(player.currentTime)
        switch trackTimeProgress {
        case ...1:
            trackContinuousSlider.setValue(1, animated: true)
        case ...2:
            trackContinuousSlider.setValue(2, animated: true)
        case ...3:
            trackContinuousSlider.setValue(3, animated: true)
        default:
            trackContinuousSlider.setValue(trackTimeProgress, animated: true)
        }
        updateTimeLabel()
    }

    @IBAction private func closeButtonPressed(_ sender: UIButton) {
        displayLink?.invalidate()
        player.stop()
        dismiss(animated: true)
    }

    @IBAction private func pauseButtonPressed(_ sender: UIButton) {
        if player.isPlaying {
            player.stop()
            displayLink?.isPaused = true
        } else {
            player.play()
            displayLink?.isPaused = false
        }
        changeStatePauseButton()
    }

    @IBAction private func forwardButtonPressed(_ sender: UIButton) {
        player.currentTime += 15
    }

    @IBAction private func backButtonPressed(_ sender: UIButton) {
        player.currentTime -= 15
    }

    @IBAction func nextTrackButtonPressed(_ sender: UIButton) {
        setupNextTrack()
    }

    @IBAction func previousTrackButtonPressed(_ sender: UIButton) {
        player.stop()
        setupPreviousTrack()
    }

    @IBAction private func openPlaylistPressed(_ sender: UIButton) {
        showAlert()
    }

    @IBAction func volumeChanged(_ sender: UISlider) {
        currentVolume = sender.value
        player.volume = sender.value
        changeStateOffVolumeButton()
    }

    @IBAction func timeTrackChanged(_ sender: UISlider) {
        player.currentTime = TimeInterval(sender.value)
    }

    @IBAction func volumeButtonPressed(_ sender: UIButton) {
        if currentVolume.isZero {
            currentVolume = lastVolume
            player.volume = lastVolume
            volumeSlider.value = lastVolume
        } else {
            lastVolume = currentVolume
            player.volume = .zero
            currentVolume = .zero
            volumeSlider.value = .zero
        }
        changeStateOffVolumeButton()
    }

    @IBAction func sharePressed(_ sender: UIButton) {
        guard let url = URL(string: "https://www.apple.com") else { return }
        let items = [url]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
}

// MARK: - Constants

private enum Constants {
    static let pauseImage = UIImage(named: "pause")
    static let playImage = UIImage(named: "play")
    static let offVolumeImage = UIImage(systemName: "volume.slash.fill")
    static let onVolumeImage = UIImage(systemName: "volume.2.fill")
}
