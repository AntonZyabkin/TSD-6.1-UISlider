//
//  PlayerViewController.swift
//  TSD-6.1-UISlider
//
//  Created by Anton Zyabkin on 04.06.2022.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController, AVAudioPlayerDelegate {
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
        player.volume = 0.5
        player.delegate = self

        
    }

    //перемешать порядок воспроизведения треков
    @IBAction func realMixButtonAction(_ sender: UIButton) {
        animateView (sender)
    }
    
    //предыдущий трек
    @IBAction func baforeButtonAction(_ sender: UIButton) {
        animateView (sender)
        beforeTrack ()
    }

    //след трек
    @IBAction func nextButtonAction(_ sender: UIButton) {
        animateView (sender)
        nextTrack ()
    }
    
    //остановка и воспроизведение трека
    @IBAction func playButtonAction(_ sender: UIButton) {
        playPauseButton (button: sender)
        animateView (sender)

    }
    
    //зацикливает воспроизведение трека
    @IBAction func mixButtonAction(_ sender: UIButton) {
        animateView (sender)
        if repeatTrack {
            repeatTrack = false
            mixButtonOunlet.tintColor = .gray
        } else {
            repeatTrack = true
            mixButtonOunlet.tintColor = .red

        }
        
    }
    
    //перемотка песни
    @IBAction func soundTrackSliderAction(_ sender: UISlider) {
        player.volume = trackPositionOutlet.value
    }
    
    
    //MARK: - @objc methods
    //функция перемотки песни при изменении положения слайдера "прогрыватель"
    @objc func changeSlider (sender: UISlider) {
        if sender == trackPositionOutlet {
            player.currentTime = TimeInterval(sender.value)
        }
    }
    
    //функция изменение значения громкости воспроизведения прейера при изменеии полодения слайдера "Громоксть"
    @IBAction func volumeSliderAction(_ sender: UISlider) {
        player.volume = soundValueOutlet.value
    }
    
    //функция воспроизводить выдранный на предыдущем экране трек по указанному пути, изменяет обложку плейера в зависимости от трека
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
    
    //функция обновляет положения бегунка на слайдере "прогрывателя" и отсчитывает сколько проиграно и сколько осталось в МИН:СЕК в двух лейблах
    @objc func updateTime () {
        trackPositionOutlet.value = Float(player.currentTime)
        
        let curentTime = player.currentTime
        let minutes = Int(curentTime/60)
        let seconds = Int (curentTime.truncatingRemainder(dividingBy: 60))
        secGoneLabel.text = NSString(format: "%02d:%02d", minutes, seconds) as String
        
        let leftTime = player.currentTime - player.duration
        let minutesLeft = Int (-leftTime/60)
        let secondsLeft = Int (-leftTime.truncatingRemainder(dividingBy: 60))
        secLeftLabel.text = "-" +  (NSString(format: "%02d:%02d", minutesLeft, secondsLeft) as String)

    }
    
    //след трек
    func nextTrack() {
        if numberOfSound > 2 {
            numberOfSound = 0
        } else { numberOfSound += 1
        }
        startPlayer ()
    }
    
    //предыдущий трек
    func beforeTrack () {
        if numberOfSound < 1 {
            numberOfSound = 3
        } else {
            numberOfSound -= 1
        }
        startPlayer ()
        
    }
    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print (repeatTrack)
        if repeatTrack {
            player.play()
        } else {
            nextTrack()
        }
    }
    
    // останавливает воспроизведение песни при возврате на экран списка песен
    override func viewWillDisappear(_ animated: Bool) {
        player.stop()
    }
}

