//
//  Sounds.swift
//  Saturn
//
//  Created by Daniel Correia on 21.03.23.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func PlaySound(sound: Sound, type: String = "wav") {
    if(SoundsOn) {
        if let path = Bundle.main.path(forResource: sound.rawValue, ofType: type) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.volume = Float(SoundsVolume)
                audioPlayer?.play()
            } catch {
                print("ERROR")
            }
        }
    }
}
