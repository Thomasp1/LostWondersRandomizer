//
//  PlayersAndCivs.swift
//  LostWondersRand
//
//  Created by ThomasPiechula on 13/05/2020.
//  Copyright © 2020 ThomasPiechula. All rights reserved.
//

import Foundation
import SwiftUI

class PlayersAndCivs: ObservableObject {
    @Published var players = [String](repeating: "", count: 10)
    @Published var civs = [String](repeating: "", count: 10)
    @Published var wonderBundles: Set = [WonderBundle.original]
    @Published var notes = ""
    @Published var teams = false
    @Published var cities: Bool = false {
        willSet {
            if newValue {
                wonderBundles.update(with: WonderBundle.cities)
            } else {
                wonderBundles.remove(WonderBundle.cities)
            }
        }
    }
    @Published var leaders: Bool = false {
        willSet {
            newValue ? wonderBundles.update(with: WonderBundle.leaders) : wonderBundles.remove(WonderBundle.leaders)
        }
    }
    @Published var wonderpack: Bool = false {
        willSet {
            if newValue {
                wonderBundles.update(with: WonderBundle.wonderpack)
            } else {
                wonderBundles.remove(WonderBundle.wonderpack)
            }
        }
    }
    @Published var armada: Bool = false {
        willSet {
            if newValue {
                wonderBundles.update(with: WonderBundle.armada)
            } else {
                wonderBundles.remove(WonderBundle.armada)
            }
        }
    }
    @Published var catan: Bool = false {
        willSet {
            if newValue {
                wonderBundles.update(with: WonderBundle.catan)
            } else {
                wonderBundles.remove(WonderBundle.catan)
            }
        }
    }
    @Published var lostWonders: Bool = false {
        willSet {
            if newValue {
                wonderBundles.update(with: WonderBundle.lostWonders)
            } else {
                wonderBundles.remove(WonderBundle.lostWonders)
            }
        }
    }
    @Published var lostWonders2: Bool = false {
        willSet {
            if newValue {
                wonderBundles.update(with: WonderBundle.lostWonders2)
            } else {
                wonderBundles.remove(WonderBundle.lostWonders2)
            }
        }
    }
    @Published var startingResourceFiltering: Bool = true
    @Published var cardColorThemeFiltering: Bool = true
    
    var actualPlayerNum: Int {
        return self.players.filter{ $0 != "" }.count
    }
    
    var temporalChoices: [String] {
        if temporalAvailable {
            return [self.civs[civs.count-1],self.civs[civs.count-2]]
        } else {
            return ["",""]
        }
    }
    
    var temporalAvailable: Bool {
        return self.civs.contains("Temporal Paradox")
    }
    
    private var soundManager = SoundManager()
    
    func playChronoSound() {
        soundManager.playChronoSound()
    }
    
    func generateCivs() {
        if self.actualPlayerNum > 2 {
            (self.civs,self.notes) = Generator.generate(
                playerNum: self.actualPlayerNum,
                bundles: self.wonderBundles,
                teams: self.teams,
                startingResourceFilter: self.startingResourceFiltering,
                cardColorFilter: self.cardColorThemeFiltering)
        }
    }
    
    func changePlayer(at: Int, name: String) {
        players[at] = name
    }
}
