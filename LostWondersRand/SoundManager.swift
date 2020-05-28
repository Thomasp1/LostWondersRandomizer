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
    
    var chronoSoundEffect: AVAudioPlayer?
    
    static let shared = SoundManager()
    private init() { }
    
    func playChronoSound() {
        guard let path = Bundle.main.path(forResource: "chronosound.caf", ofType: nil) else { return }
        let url = URL(fileURLWithPath: path)
        
        do {
            chronoSoundEffect = try AVAudioPlayer(contentsOf: url)
            chronoSoundEffect?.play()
        } catch {
            debugPrint("couldn't load file")
        }
        
    }
    
}
