//
//  SoundManager.swift
//  LostWondersRand
//
//  Created by ThomasPiechula on 28/05/2020.
//  Copyright © 2020 ThomasPiechula. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager {
    
    private var defaultPlayer: AVAudioPlayer?
    
    func playChronoSound() {
        playSound(resource: "chronosound.caf")
    }
    
    func playLongChronoSound() {
        playSound(resource: "chronolong_downsampled.caf")
    }
    
    func playPowerDown() {
        playSound(resource: "powerdown.caf")
    }
    
    private func playSound(resource: String) {
        guard let path = Bundle.main.path(forResource: resource, ofType: nil) else {
            debugPrint("couldn't find file: \(resource)")
            return
        }
        let url = URL(fileURLWithPath: path)
        
        do {
            defaultPlayer = try AVAudioPlayer(contentsOf: url)
            defaultPlayer?.play()
        } catch {
            debugPrint("couldn't load file: \(resource)")
        }
    }
    
    func stop() {
        defaultPlayer?.stop()
    }
    
}
