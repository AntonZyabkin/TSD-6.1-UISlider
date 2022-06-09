//
//  PlayerViewController.swift
//  TSD-6.1-UISlider
//
//  Created by Anton Zyabkin on 04.06.2022.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    @IBOutlet weak var SoundNameLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var secLeftLabel: UILabel!
    @IBOutlet weak var secGoneLabel: UILabel!
    
    @IBOutlet weak var realMixButtonOunlet: UIButton!
    @IBOutlet weak var beforeButtonOunlet: UIButton!
    @IBOutlet weak var playButtonOunlet: UIButton!
    @IBOutlet weak var nextButtonOunlet: UIButton!
    @IBOutlet weak var mixButtonOunlet: UIButton!
    @IBOutlet weak var trackPositionOutlet: UISlider!
    @IBOutlet weak var soundValueOutlet: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coverImageView.image = UIImage(named: imagesArray[numberOfSound])
        SoundNameLabel.text = soundTracksArray[numberOfSound]
        
        trackPositionOutlet.minimumValue = 0
        trackPositionOutlet.maximumValue = 100
        trackPositionOutlet.isContinuous = false
        trackPositionOutlet.addTarget(self, action: #selector(changeSlider), for: UIControl.Event.valueChanged)

        startPlayer ()
        
        
        
    }

    @IBAction func realMixButtonAction(_ sender: UIButton) {
        animateView (sender)
    }
    @IBAction func baforeButtonAction(_ sender: UIButton) {
        animateView (sender)
        if numberOfSound > 3 {
            numberOfSound = 0
        } else if numberOfSound < 0 {
            numberOfSound = 3
        } else {
            numberOfSound -= 1
        }
        startPlayer ()
        
    }
    @IBAction func playButtonAction(_ sender: UIButton) {
        playPauseButton (button: sender)
        animateView (sender)

    }
    @IBAction func nextButtonAction(_ sender: UIButton) {
        animateView (sender)
        if numberOfSound > 2 {
            numberOfSound = 0
        } else if numberOfSound < 1 {
            numberOfSound = 3
        } else { numberOfSound += 1
        }
        startPlayer ()
    }
    @IBAction func mixButtonAction(_ sender: UIButton) {
        animateView (sender)
    }
    @IBAction func soundTrackSliderAction(_ sender: UISlider) {
        player.volume = trackPositionOutlet.value
    }
    
    
    //MARK: - @objc methods
    
    @objc func changeSlider (sender: UISlider) {
        if sender == trackPositionOutlet {
            player.currentTime = TimeInterval(sender.value)
        }
        print ("somth")
    }
    
    
    
    func startPlayer () {
        do {
            if let audioPath = Bundle.main.path(forResource: soundTracksArray[numberOfSound], ofType: "mp3") {
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
                soundValueOutlet.maximumValue = Float(player.duration)
            }
        } catch {
            print("ERROR ujdyj")
        }
        player.play()
    }
}
