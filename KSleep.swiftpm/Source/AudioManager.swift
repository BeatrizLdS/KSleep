//
//  File.swift
//  
//
//  Created by Beatriz Leonel da Silva on 17/04/23.
//

import Foundation
import AVFoundation

enum SoundTypes: String {
    case game = "ClockSound"
    case wind = "WindSound"
    case light = "EletricHum"
    case computerMusic = "ComputerMusic"
    case victory = "WinSound"
    case gameOver = "GameOver"
}

class AudioManager {
    
    static let shared = AudioManager()
    
    var players = [URL: AVAudioPlayer]()
    
    func playSound(sound: SoundTypes) {
        if let urlString = Bundle.main.path(forResource: sound.rawValue, ofType: "mp3") {
            guard let url = URL(string: urlString) else { return }
            
            if let player = players[url] {
                if player.isPlaying == false {
                    play(player: player, sound: sound)
                }
            }
            else {
                do {
                    let audioPlayer = try AVAudioPlayer(contentsOf: url)
                    players[url] = audioPlayer
                    play(player: audioPlayer, sound: sound)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func play(player: AVAudioPlayer, sound: SoundTypes) {
        if sound != .gameOver && sound != .victory {
            player.numberOfLoops = -1
        }
        player.prepareToPlay()
        player.play()
    }
    
    func turnSoundOff (sound: SoundTypes) {
        if let urlString = Bundle.main.path(forResource: sound.rawValue, ofType: "mp3") {
            guard let url = URL(string: urlString) else { return }
            if let player = players[url] {
                player.stop()
            }
        }
    }
    
    func turnAllSoundsOff() {
        for player in players {
            let audioPlayer = player.value
            audioPlayer.stop()
        }
    }
    
    
}
