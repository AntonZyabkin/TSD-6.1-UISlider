//
//  PlayerMadel.swift
//  TSD-6.1-UISlider
//
//  Created by Anton Zyabkin on 07.06.2022.
//

import Foundation
import AVFoundation
import UIKit


var player = AVAudioPlayer ()
var position = 1







//MARK: - funcs
//при нажатии на клавишу пауза/плей сменяется имейдж кнопки
func playPauseButton (button: UIButton) {
    if position == 0 {
        player.play()
        button.setImage(UIImage(systemName: "pause"), for: .normal)
        position = 1
    } else {
        player.pause()
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        position = 0
    }
}


