//
//  Sounds.swift
//  Saturn
//
//  Created by Daniel Correia on 21.03.23.
//

import SwiftUI
import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func PlaySound(sound: Sound, type: String = "wav") {
    if(SoundsOn) {
        _Concurrency.Task {
            if let path = Bundle.main.path(forResource: sound.rawValue, ofType: type) {
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers])
                    try AVAudioSession.sharedInstance().setActive(true)
                    audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                    audioPlayer?.volume = Float(SoundsVolume)
                    audioPlayer?.play()
                } catch {
                    print("ERROR")
                }
            }
        }
    }
}
