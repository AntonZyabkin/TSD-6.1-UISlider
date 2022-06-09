//
//  PlayerViewController.swift
//  TSD-6.1-UISlider
//
//  Created by Anton Zyabkin on 04.06.2022.
//

import UIKit

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
        numberOfSound
        coverImageView.image

    }

    @IBAction func realMixButtonAction(_ sender: UIButton) {
        animateView (sender)
    }
    @IBAction func baforeButtonAction(_ sender: UIButton) {
        animateView (sender)
    }
    @IBAction func playButtonAction(_ sender: UIButton) {
        playPauseButton (button: sender)
        animateView (sender)

    }
    @IBAction func nextButtonAction(_ sender: UIButton) {
        animateView (sender)
    }
    @IBAction func mixButtonAction(_ sender: UIButton) {
        animateView (sender)
    }
    
    
    //MARK: - @objc methods
    
    @objc func changeSlider (sender: UISlider) {
        if sender == trackPositionOutlet {
            player.currentTime = TimeInterval(sender.value)
        }
    }
}
