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
    @Published var players = [String](repeating: "", count: 8)
    @Published var civs = [String](repeating: "", count: 8)
    @Published var wonderBundles: Set = [WonderBundle.original]
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
    
    func changePlayer(at: Int, name: String) {
        players[at] = name
    }
}
