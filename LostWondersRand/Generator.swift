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
    
    static func generate(playerNum: Int, bundles: [WonderBundle], teams: Bool) -> [String] {
        
        var chosenWonders = [String:Wonder]()
        
        //add enabled bundles
        bundles.forEach {
            for key in $0.getDict().keys {
                chosenWonders[key] = $0.getDict()[key]
            }
        }
        
        //filter teams
        if teams {
            chosenWonders = chosenWonders.filter {
                if let req = $0.value.requirements {
                    return !req.contains("No Teams")
                } else { return true }
            }
        } else {
            chosenWonders = chosenWonders.filter {
                if let req = $0.value.requirements {
                    return !req.contains("Teams Only")
                } else { return true }
            }
        }
        
        
        let chosenWondersString: [String] = Array(chosenWonders.keys)
        return chosenWondersString
    }
}
