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
    
    @IBOutlet weak var NavItemOutlet: UINavigationItem!
    var timer : Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        trackPositionOutlet.minimumValue = 0
        trackPositionOutlet.maximumValue = 100
        soundValueOutlet.minimumValue = 0.0
        soundValueOutlet.maximumValue = 1.0
        trackPositionOutlet.isContinuous = false
        trackPositionOutlet.addTarget(self, action: #selector(changeSlider), for: UIControl.Event.valueChanged)

        startPlayer ()
        print (player.currentTime)
        
        
        
    }

    @IBAction func realMixButtonAction(_ sender: UIButton) {
        animateView (sender)
    }
    @IBAction func baforeButtonAction(_ sender: UIButton) {
        animateView (sender)
        if numberOfSound < 1 {
            numberOfSound = 3
        } else {
            numberOfSound -= 1
        }
        startPlayer ()
        
    }

    @IBAction func nextButtonAction(_ sender: UIButton) {
        animateView (sender)
        if numberOfSound > 2 {
            numberOfSound = 0
        } else { numberOfSound += 1
        }
        startPlayer ()
    }
    
    @IBAction func playButtonAction(_ sender: UIButton) {
        playPauseButton (button: sender)
        animateView (sender)

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
    }
    
    
    @IBAction func volumeSliderAction(_ sender: UISlider) {
        player.volume = soundValueOutlet.value
    }
    
    
    
    func startPlayer () {
        do {
            if let audioPath = Bundle.main.path(forResource: soundTracksArray[numberOfSound], ofType: "mp3") {
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
                trackPositionOutlet.maximumValue = Float(player.duration)
                trackPositionOutlet.value = Float(player.currentTime)
            }
        } catch {
            print("ERROR ujdyj")
        }
        player.play()
        coverImageView.image = UIImage(named: imagesArray[numberOfSound])
        SoundNameLabel.text = soundTracksArray[numberOfSound]
        trackPositionOutlet.value = 0
        playButtonOunlet.setImage(UIImage(systemName: "pause"), for: .normal)
        position = 1
    }
    @objc func updateTime () {
        trackPositionOutlet.value = Float(player.currentTime)
        
        let curentTime = player.currentTime
        let minutes = Int(curentTime/60)
        let seconds = Int (curentTime.truncatingRemainder(dividingBy: 60))
        secGoneLabel.text = NSString(format: "%02d:%02d", minutes, seconds) as String
        
        let leftTime = player.currentTime - player.duration
        let minutesLeft = Int (leftTime/60)
        let secondsLeft = Int (-leftTime.truncatingRemainder(dividingBy: 60))
        secLeftLabel.text = NSString(format: "%02d:%02d", minutesLeft, secondsLeft) as String

    }
}
