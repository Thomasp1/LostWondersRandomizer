//
//  PlayersAndCivs.swift
//  LostWondersRand
//
//  Created by ThomasPiechula on 13/05/2020.
//  Copyright © 2020 ThomasPiechula. All rights reserved.
//

import Foundation

class PlayersAndCivs: ObservableObject {
    @Published var players = [String](repeating: "", count: 8)
    @Published var civs = [String](repeating: "", count: 8)
    @Published var wonderBundles: Set = [WonderBundle.original]
    @Published var teams = false
    @Published var cities = false
    @Published var leaders = false
    @Published var wonderpack = false
    @Published var armada = false
    @Published var catan = false
    @Published var lostWonders = false
    @Published var lostWonders2 = false
    
    func changePlayer(at: Int, name: String) {
        players[at] = name
    }
    
    func enableBundle(civ: WonderBundle) {
        wonderBundles.insert(civ)
    }
    
    func disableBundle(civ: WonderBundle) {
        wonderBundles.remove(civ)
    }
}
