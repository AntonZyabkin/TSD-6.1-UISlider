//
//  PlayerMadel.swift
//  TSD-6.1-UISlider
//
//  Created by Anton Zyabkin on 07.06.2022.
//

import Foundation
import AVFoundation
import UIKit


let player = AVAudioPlayer ()
var position = 0







//MARK: - funcs

func playPauseButton (button: UIButton) {
    if position == 0 {
        player.play()
        button.setImage(UIImage(systemName: "pause"), for: .normal)
        position = 1
        print(position)
    } else {
        player.pause()
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        position = 0
        print(position)
    }
}
