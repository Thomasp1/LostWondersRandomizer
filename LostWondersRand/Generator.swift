//
//  Generator.swift
//  LostWondersRand
//
//  Created by ThomasPiechula on 12/05/2020.
//  Copyright © 2020 ThomasPiechula. All rights reserved.
//

import Foundation

enum WonderBundle {
    case original
    case cities
    case leaders
    case wonderpack
    case catan
    case armada
    case lostWonders
    case lostWonders2
    
    func getDict() -> [String:Wonder] {
        switch self {
        case .original:
            return Bundle.main.decode([String:Wonder].self, from: "OriginalWonders.json")
        case .cities:
            return Bundle.main.decode([String:Wonder].self, from: "CitiesWonders.json")
        case .leaders:
            return Bundle.main.decode([String:Wonder].self, from: "LeadersWonder.json")
        case .wonderpack:
            return Bundle.main.decode([String:Wonder].self, from: "WonderPackWonders.json")
        case .catan:
            return Bundle.main.decode([String:Wonder].self, from: "CatanWonder.json")
        case .armada:
            return Bundle.main.decode([String:Wonder].self, from: "ArmadaWonder.json")
        case .lostWonders:
            return Bundle.main.decode([String:Wonder].self, from: "LostWonders.json")
        case .lostWonders2:
            return Bundle.main.decode([String:Wonder].self, from: "LostWonders2.json")
        }
    }
}

class Generator {
    
    static func generate(playerNum: Int) -> [String] {
        var chosenCivs = [String](repeating: "", count: 8)
        let randWonderKey = WonderBundle.original.getDict().keys.randomElement() ?? "No Wonder"
        chosenCivs[0] = randWonderKey
        chosenCivs = Array(WonderBundle.lostWonders.getDict().keys.shuffled().prefix(8))
        
        return chosenCivs
    }
}
