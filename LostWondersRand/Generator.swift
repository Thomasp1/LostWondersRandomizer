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
    
    static let stupidWonders = ["Nomades"]
    static let wondercopyWonders = ["Manneken Pis","DoppelWonder","Venezia","Myst","Trojan Horse","Springfield","Machu Picchu"]
    static let wondercopyIncompatibleWonders = ["Atlantis","Chichen Itza","Ephyra","Tartaros","Temporal Paradox","Uruk","Dominion","Antiocheia","Helvetia","Petra","Brigadoon","Elysion Pedion"]
    
    static func generate(playerNum: Int, bundles: Set<WonderBundle>, teams: Bool) -> [String] {
        
        var combinedWonders = [String:Wonder]()
        var finalWondersChosen = [String:Wonder]()
        
        //add enabled bundles
        bundles.forEach {
            for key in $0.getDict().keys {
                combinedWonders[key] = $0.getDict()[key]
            }
        }
        
        //filter wonders that require/cannot play with teams
        if teams {
            combinedWonders = combinedWonders.filter { if let req = $0.value.requirements { return !req.contains("No Teams") } else { return true }}
        } else {
            combinedWonders = combinedWonders.filter { if let req = $0.value.requirements { return !req.contains("Teams Only") } else { return true }}
        }
        
        //player amount requirements
        if playerNum < 4 {
            combinedWonders = combinedWonders.filter { if let req = $0.value.requirements { return !req.contains("4 Players or more") } else { return true }}
        }
        if playerNum < 5 {
            combinedWonders = combinedWonders.filter { if let req = $0.value.requirements { return !req.contains("5 Players or more") } else { return true }}
        }
        
        //expansion pack requirements
        if !bundles.contains(WonderBundle.cities) {
            combinedWonders = combinedWonders.filter { if let req = $0.value.requirements { return !req.contains("Cities") } else { return true }}
        }
        if !bundles.contains(WonderBundle.leaders) {
            combinedWonders = combinedWonders.filter { if let req = $0.value.requirements { return !req.contains("Leaders") } else { return true }}
        }
        if !bundles.contains(WonderBundle.armada) {
            combinedWonders = combinedWonders.filter { if let req = $0.value.requirements { return !req.contains("Armada") } else { return true }}
        }
        
        
        var wondercopyNum = 0
        var incompatibleNum = 0
        var temporalParadoxChosen = false
        var temporalRescue = [String:Wonder]()
        
        //select wonders
        for _ in 0..<playerNum {
            guard let selectedWonder = combinedWonders.randomElement() else { break }
            
            switch selectedWonder {
            case let element where self.stupidWonders.contains(element.key):
                //add wonder to chosen wonders
                finalWondersChosen[selectedWonder.key] = selectedWonder.value
                combinedWonders.removeValue(forKey: selectedWonder.key)
                
                //remove wonder copying wonders
                combinedWonders = combinedWonders.filter { !(self.wondercopyWonders.contains($0.key)) }
            case let element where self.wondercopyWonders.contains(element.key):
                wondercopyNum += 1
                let troubleWondersNum = wondercopyNum + incompatibleNum
                
                //add wonder to chosen wonders
                finalWondersChosen[selectedWonder.key] = selectedWonder.value
                combinedWonders.removeValue(forKey: selectedWonder.key)
                
                //if we reach the max limit for how many wondercopy/incompatible wonders we can put in
                if troubleWondersNum == playerNum / 2 {
                    //remove wonder copying wonders
                    combinedWonders = combinedWonders.filter { !(self.wondercopyWonders.contains($0.key)) }
                    //remove copying incompatible wonders
                    combinedWonders = combinedWonders.filter { !(self.wondercopyIncompatibleWonders.contains($0.key)) }
                }
                
                //if no normal wonders are chosen yet to neighbour the wondercopy wonders, we should stop getting more incompatible wonders
                if ((wondercopyNum * 2) + 1) + incompatibleNum == playerNum {
                    combinedWonders = combinedWonders.filter { !(self.wondercopyIncompatibleWonders.contains($0.key)) }
                }
                
                //remove stupid wonders
                combinedWonders = combinedWonders.filter { !(self.stupidWonders.contains($0.key)) }
                
            case let element where self.wondercopyIncompatibleWonders.contains(element.key):
                incompatibleNum += 1
                let troubleWondersNum = wondercopyNum + incompatibleNum
                
                finalWondersChosen[selectedWonder.key] = selectedWonder.value
                combinedWonders.removeValue(forKey: selectedWonder.key)
                
                if selectedWonder.key == "Temporal Paradox" { temporalParadoxChosen = true }
                
                if troubleWondersNum == playerNum / 2 {
                    combinedWonders = combinedWonders.filter { !(self.wondercopyWonders.contains($0.key)) }
                    combinedWonders = combinedWonders.filter { !(self.wondercopyIncompatibleWonders.contains($0.key)) }
                }
                
                if wondercopyNum != 0 {
                    //if no normal wonders are chosen yet to neighbour the wondercopy wonders, we should stop getting more incompatible wonders
                    if ((wondercopyNum * 2) + 1) + incompatibleNum == playerNum {
                        combinedWonders = combinedWonders.filter { !(self.wondercopyIncompatibleWonders.contains($0.key)) }
                    }
                } else {
                    //its possible to choose so many incompatible wonders, that there is no room left for wonder-copying wonders
                    if ((wondercopyNum * 2) + 1) + incompatibleNum > playerNum {
                        combinedWonders = combinedWonders.filter { !(self.wondercopyWonders.contains($0.key)) }
                    }
                }
                
            default:
                //normal wonders that don't cause trouble
                finalWondersChosen[selectedWonder.key] = selectedWonder.value
                combinedWonders.removeValue(forKey: selectedWonder.key)
            }
        }
        
        var temporalChosen = [String]()
        if finalWondersChosen["Temporal Paradox"] != nil {
            if let temporalChoiceOne = combinedWonders.randomElement() {
                temporalChosen.append(temporalChoiceOne.key)
                combinedWonders.removeValue(forKey: temporalChoiceOne.key)
            }
            if let temporalChoiceTwo = combinedWonders.randomElement() {
                temporalChosen.append(temporalChoiceTwo.key)
                combinedWonders.removeValue(forKey: temporalChoiceTwo.key)
            }
            
        }
        
        
        var finalWondersString: [String] = Array(finalWondersChosen.keys)
        finalWondersString.shuffle()
        
        if finalWondersString.count < 8 {
            for _ in finalWondersString.count ... 8 {
                finalWondersString.append("")
            }
        }
        
        debugPrint(finalWondersString + temporalChosen)
        
        return finalWondersString + temporalChosen
    }
}
