//
//  AudioPlayer.swift
//  Restart
//
//  Created by Kamil Chlebuś on 06/09/2023.
//

import AVFAudio

var audioPlayer: AVAudioPlayer?

func play(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(filePath: path))
            audioPlayer?.play()
        } catch {
            print("Could not play the sound file.")
        }
    }
}
