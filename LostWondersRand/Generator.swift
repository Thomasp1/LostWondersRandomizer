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

enum CardColor: String {
    case red
    case blue
    case yellow
    case green
    case brown
    case black
    case purple
    
    var associatedPowers: [String] {
        switch self {
        case .red:
            return ["Victory Points for Shields","Shields","Coin for Red Card","Victory Points for Red Card"]
        case .blue:
            return ["Coin for Blue Card","Victory Points for Blue Card"]
        case .yellow:
            return ["Victory Points for Yellow Card","Double Coins for Yellow Card","Double Victory Points for Yellow Card","Coin for Yellow Card"]
        case .green:
            return ["Coin for Green Card","Money for Green Cards Stage 2","Victory Points for Green Card","Victory Points for Science Set","Convert Science Symbol","Science Choice"]
        case .brown:
            return ["Coin for Brown Card","Victory Points for Brown Card"]
        case .black:
            return ["Black Card Discount","Draw Black Card Build Free"]
        case .purple:
            return ["Purple Card Discount","Victory Points for Purple Card","Draw Purple Card Build Free","Purple Build Discard Build Free","Count Self Cards for Guild"]
        }
    }
    
    static var allValues: [CardColor] {
        var allValues: [CardColor] = []
        switch (CardColor.red) {
        case .red: allValues.append(.red);fallthrough
        case .blue: allValues.append(.blue);fallthrough
        case .yellow: allValues.append(.yellow);fallthrough
        case .green: allValues.append(.green);fallthrough
        case .brown: allValues.append(.brown);fallthrough
        case .black: allValues.append(.black);fallthrough
        case .purple: allValues.append(.purple);
        }
        return allValues
    }
}

class Generator {
    
    private static var combinedWonders = [String:Wonder]()
    private static var remainingChoiceWonders = [String:Wonder]()
    private static var finalWondersChosen = [String:Wonder]()
    private static var startingResourceCounter = [String:Int]()
    private static var cardColorThemeCounter = NSCountedSet()
    
    //civ that can't be in a game with any civs that has wonder-copying ability, whatsoever
    static let stupidWonders = ["Nomades"]
    //civs with wonder-copying ability
    static let wondercopyWonders = ["Manneken Pis","DoppelWonder","Venezia","Myst","Trojan Horse","Springfield","Machu Picchu"]
    //civs that cannot be next to a civ with wonder-copying ability
    static let wondercopyIncompatibleWonders = ["Atlantis","Chichen Itza","Ephyra","Tartaros","Temporal Paradox","Uruk","Dominion","Antiocheia","Helvetia","Petra","Brigadoon","Elysion Pedion"]
    
    static func generate(playerNum: Int, bundles: Set<WonderBundle>, teams: Bool) -> ([String],String) {
        
        combinedWonders.removeAll()
        remainingChoiceWonders.removeAll()
        finalWondersChosen.removeAll()
        startingResourceCounter.removeAll()
        cardColorThemeCounter.removeAllObjects()
        
        //add enabled bundles
        bundles.forEach {
            for key in $0.getDict().keys {
                combinedWonders[key] = $0.getDict()[key]
            }
        }
        remainingChoiceWonders = combinedWonders
        
        //filter wonders that require/cannot play with teams
        if teams {
            remainingChoiceWonders = remainingChoiceWonders.filter { if let req = $0.value.requirements { return !req.contains("No Teams") } else { return true }}
        } else {
            remainingChoiceWonders = remainingChoiceWonders.filter { if let req = $0.value.requirements { return !req.contains("Teams Only") } else { return true }}
        }
        
        //player amount requirements
        if playerNum < 4 {
            remainingChoiceWonders = remainingChoiceWonders.filter { if let req = $0.value.requirements { return !req.contains("4 Players or more") } else { return true }}
        }
        if playerNum < 5 {
            remainingChoiceWonders = remainingChoiceWonders.filter { if let req = $0.value.requirements { return !req.contains("5 Players or more") } else { return true }}
        }
        
        //expansion pack requirements
        if !bundles.contains(WonderBundle.cities) {
            remainingChoiceWonders = remainingChoiceWonders.filter { if let req = $0.value.requirements { return !req.contains("Cities") } else { return true }}
        }
        if !bundles.contains(WonderBundle.leaders) {
            remainingChoiceWonders = remainingChoiceWonders.filter { if let req = $0.value.requirements { return !req.contains("Leaders") } else { return true }}
        }
        if !bundles.contains(WonderBundle.armada) {
            remainingChoiceWonders = remainingChoiceWonders.filter { if let req = $0.value.requirements { return !req.contains("Armada") } else { return true }}
        }
        
        
        var wondercopyNum = 0
        var incompatibleNum = 0
        var temporalParadoxChosen = false
        var temporalRescue = [String:Wonder]()
        
        //select wonders
        for _ in 0..<playerNum {
            guard let selectedWonder = remainingChoiceWonders.randomElement() else { break }
            
            switch selectedWonder {
            case let element where self.stupidWonders.contains(element.key):
                //add wonder to chosen wonders
                finalWondersChosen[selectedWonder.key] = selectedWonder.value
                remainingChoiceWonders.removeValue(forKey: selectedWonder.key)
                
                //remove wonder copying wonders
                remainingChoiceWonders = remainingChoiceWonders.filter { !(self.wondercopyWonders.contains($0.key)) }
            case let element where self.wondercopyWonders.contains(element.key):
                wondercopyNum += 1
                let troubleWondersNum = wondercopyNum + incompatibleNum
                
                //add wonder to chosen wonders
                finalWondersChosen[selectedWonder.key] = selectedWonder.value
                remainingChoiceWonders.removeValue(forKey: selectedWonder.key)
                
                //if we reach the max limit for how many wondercopy/incompatible wonders we can put in
                if troubleWondersNum == playerNum / 2 {
                    //remove wonder copying wonders
                    remainingChoiceWonders = remainingChoiceWonders.filter { !(self.wondercopyWonders.contains($0.key)) }
                    //remove copying incompatible wonders
                    if temporalParadoxChosen {
                        temporalRescue = remainingChoiceWonders.filter { (self.wondercopyIncompatibleWonders.contains($0.key)) }
                    }
                    remainingChoiceWonders = remainingChoiceWonders.filter { !(self.wondercopyIncompatibleWonders.contains($0.key)) }
                }
                
                //if no normal wonders are chosen yet to neighbour the wondercopy wonders, we should stop getting more incompatible wonders
                if ((wondercopyNum * 2) + 1) + incompatibleNum == playerNum {
                    if temporalParadoxChosen {
                        temporalRescue = remainingChoiceWonders.filter { (self.wondercopyIncompatibleWonders.contains($0.key)) }
                    }
                    remainingChoiceWonders = remainingChoiceWonders.filter { !(self.wondercopyIncompatibleWonders.contains($0.key)) }
                }
                
                //remove stupid wonders
                remainingChoiceWonders = remainingChoiceWonders.filter { !(self.stupidWonders.contains($0.key)) }
                
            case let element where self.wondercopyIncompatibleWonders.contains(element.key):
                incompatibleNum += 1
                let troubleWondersNum = wondercopyNum + incompatibleNum
                
                finalWondersChosen[selectedWonder.key] = selectedWonder.value
                remainingChoiceWonders.removeValue(forKey: selectedWonder.key)
                
                if selectedWonder.key == "Temporal Paradox" { temporalParadoxChosen = true }
                
                if troubleWondersNum == playerNum / 2 {
                    remainingChoiceWonders = remainingChoiceWonders.filter { !(self.wondercopyWonders.contains($0.key)) }
                    if temporalParadoxChosen {
                        temporalRescue = remainingChoiceWonders.filter { (self.wondercopyIncompatibleWonders.contains($0.key)) }
                    }
                    remainingChoiceWonders = remainingChoiceWonders.filter { !(self.wondercopyIncompatibleWonders.contains($0.key)) }
                }
                
                if wondercopyNum != 0 {
                    //if no normal wonders are chosen yet to neighbour the wondercopy wonders, we should stop getting more incompatible wonders
                    if ((wondercopyNum * 2) + 1) + incompatibleNum == playerNum {
                        if temporalParadoxChosen {
                            temporalRescue = remainingChoiceWonders.filter { (self.wondercopyIncompatibleWonders.contains($0.key)) }
                        }
                        remainingChoiceWonders = remainingChoiceWonders.filter { !(self.wondercopyIncompatibleWonders.contains($0.key)) }
                    }
                } else {
                    //its possible to choose so many incompatible wonders, that there is no room left for wonder-copying wonders
                    if ((wondercopyNum * 2) + 1) + incompatibleNum > playerNum {
                        remainingChoiceWonders = remainingChoiceWonders.filter { !(self.wondercopyWonders.contains($0.key)) }
                    }
                }
                
            default:
                //normal wonders that don't cause trouble
                finalWondersChosen[selectedWonder.key] = selectedWonder.value
                remainingChoiceWonders.removeValue(forKey: selectedWonder.key)
            }
            
            if bundles.contains(WonderBundle.lostWonders) || bundles.contains(WonderBundle.lostWonders2) {
                remainingChoiceWonders = filterStartingResources(remainingWonders: &remainingChoiceWonders, chosenWonder: selectedWonder.key)
            }
            
        }
        
        var temporalChosen = [String]()
        if finalWondersChosen["Temporal Paradox"] != nil {
            debugPrint("temporalRescue: \(temporalRescue.keys)")
            var temporalChoices: [String:Wonder] = remainingChoiceWonders.merging(temporalRescue) { (current,_) in current }
            debugPrint("temporalChoices: \(temporalChoices.keys)")
            if let temporalChoiceOne = temporalChoices.randomElement() {
                temporalChosen.append(temporalChoiceOne.key)
                remainingChoiceWonders.removeValue(forKey: temporalChoiceOne.key)
                temporalChoices.removeValue(forKey: temporalChoiceOne.key)
            }
            if let temporalChoiceTwo = temporalChoices.randomElement() {
                temporalChosen.append(temporalChoiceTwo.key)
                remainingChoiceWonders.removeValue(forKey: temporalChoiceTwo.key)
                temporalChoices.removeValue(forKey: temporalChoiceTwo.key)
            }
            
        }
        
        
        var finalWondersString: [String] = Array(finalWondersChosen.keys)
        finalWondersString.shuffle()
        
        if finalWondersString.count < 8 {
            for _ in finalWondersString.count ... 8 {
                finalWondersString.append("")
            }
        }
        
        debugPrint("finalWonderString: \(finalWondersString)")
        debugPrint("temporalChosen: \(temporalChosen)")
        debugPrint("resourceCounter: \(startingResourceCounter)")
        
        let finalStringArray = finalWondersString + temporalChosen
        let notes = getNotes(chosenWonders: finalWondersChosen)
        return (finalStringArray,notes)
    }
    
    private static func filterStartingResources(remainingWonders: inout [String:Wonder], chosenWonder: String) -> [String:Wonder] {
        
        guard var resourceNameA = combinedWonders[chosenWonder]?.a.resource,
            var resourceNameB = combinedWonders[chosenWonder]?.b.resource else {
                return remainingWonders
        }
        
        //assuming dual/split starting resources are identical on A side and B side
        if resourceNameA.contains(",") {
            let resourceSplitArray = resourceNameA.split(separator: ",")
            resourceNameA = String(resourceSplitArray[0])
            resourceNameB = String(resourceSplitArray[1])
        } else if resourceNameA.contains("/") {
            let resourceSplitArray = resourceNameA.split(separator: "/")
            resourceNameA = String(resourceSplitArray[0])
            resourceNameB = String(resourceSplitArray[1])
        }
        
        startingResourceCounter[resourceNameA] = (startingResourceCounter[resourceNameA] ?? 0) + 1
        if startingResourceCounter[resourceNameA] == 3 {
            remainingWonders.keys.forEach {
                if let wr = remainingWonders[$0]?.a.resource {
                    debugPrint("wr: \(wr)")
                    if wr.contains(",") {
                        let resourceSplitArray = wr.split(separator: ",")
                        debugPrint("splitArray: \(resourceSplitArray)")
                        if resourceNameA == resourceSplitArray[0] || resourceNameA == resourceSplitArray[1] {
                            remainingWonders[$0] = nil
                        }
                    } else if wr.contains("/") {
                        let resourceSplitArray = wr.split(separator: "/")
                        debugPrint("splitArray: \(resourceSplitArray)")
                        if resourceNameA == resourceSplitArray[0] || resourceNameA == resourceSplitArray[1] {
                            remainingWonders[$0] = nil
                        }
                    } else {
                        if wr == resourceNameA {
                            remainingWonders[$0] = nil
                        }
                    }
                }
                
            }
        }
        if resourceNameA != resourceNameB {
            startingResourceCounter[resourceNameB] = (startingResourceCounter[resourceNameB] ?? 0) + 1
            if startingResourceCounter[resourceNameB] == 3 {
                remainingWonders.keys.forEach {
                    if let wr = remainingWonders[$0]?.b.resource {
                        debugPrint("wr: \(wr)")
                        if wr.contains(",") {
                            let resourceSplitArray = wr.split(separator: ",")
                            debugPrint("splitArray: \(resourceSplitArray)")
                            if resourceNameB == resourceSplitArray[0] || resourceNameB == resourceSplitArray[1] {
                                remainingWonders[$0] = nil
                            }
                        } else if wr.contains("/") {
                            let resourceSplitArray = wr.split(separator: "/")
                            debugPrint("splitArray: \(resourceSplitArray)")
                            if resourceNameB == resourceSplitArray[0] || resourceNameB == resourceSplitArray[1] {
                                remainingWonders[$0] = nil
                            }
                        } else {
                            if wr == resourceNameB {
                                remainingWonders[$0] = nil
                            }
                        }
                    }
                    
                }
            }
        }
        return remainingWonders
        
    }
    
    private static func filterCardPowers(remainingWonders: inout [String:Wonder], chosenWonder: String) {
        var wonderThemeCounter = [CardColor:Bool]()
        
        guard var chosenPowersA = combinedWonders[chosenWonder]?.a.theme,
            var chosenPowersB = combinedWonders[chosenWonder]?.b.theme else {
            return
        }
        let combinedPowers = chosenPowersA + chosenPowersB
        
        wonderThemeCounter[CardColor.red] = combinedPowers.contains(where: CardColor.red.associatedPowers.contains)
        wonderThemeCounter[CardColor.blue] = combinedPowers.contains(where: CardColor.blue.associatedPowers.contains)
        wonderThemeCounter[CardColor.yellow] = combinedPowers.contains(where: CardColor.yellow.associatedPowers.contains)
        wonderThemeCounter[CardColor.green] = combinedPowers.contains(where: CardColor.green.associatedPowers.contains)
        wonderThemeCounter[CardColor.brown] = combinedPowers.contains(where: CardColor.brown.associatedPowers.contains)
        wonderThemeCounter[CardColor.black] = combinedPowers.contains(where: CardColor.black.associatedPowers.contains)
        wonderThemeCounter[CardColor.purple] = combinedPowers.contains(where: CardColor.purple.associatedPowers.contains)
    }
    
    private static func getNotes(chosenWonders: [String:Wonder]) -> String {
        
        var requiresDice = false
        var removeMidas = false
        var removeAlexander = false
        var requiresDominionCard = false
        var requiresExtraPurpleCards = false
        var requiresExtraBlackCards = false
        var wondercopyWondersNum = 0
        var incompatibleWondersNum = 0
        var wonderCopyList = ""
        var incompatibleList = ""
        var finalNotesText = ""
        
        chosenWonders.keys.forEach {
            if chosenWonders[$0]?.requirements?.contains("Dice") ?? false {
                requiresDice = true
            }
            if chosenWonders[$0]?.requirements?.contains("No Midas Leader") ?? false {
                removeMidas = true
            }
            if chosenWonders[$0]?.requirements?.contains("No Alexander Leader") ?? false {
                removeAlexander = true
            }
            if chosenWonders[$0]?.requirements?.contains("Dominion Card") ?? false {
                requiresDominionCard = true
            }
            if chosenWonders[$0]?.requirements?.contains("Extra Guild Cards") ?? false {
                requiresExtraPurpleCards = true
            }
            if chosenWonders[$0]?.requirements?.contains("Extra City Cards") ?? false {
                requiresExtraBlackCards = true
            }
            
            switch $0 {
                case let key where self.wondercopyWonders.contains(key):
                wondercopyWondersNum += 1
                
                if wondercopyWondersNum == 1 {
                    wonderCopyList = $0
                } else if wondercopyWondersNum == 2 {
                    wonderCopyList += ", " + $0
                } else if wondercopyWondersNum > 2 {
                    wonderCopyList += ", " + $0
                }
                case let key where self.wondercopyIncompatibleWonders.contains(key):
                incompatibleWondersNum += 1
                incompatibleList += $0 + ", "
            default:
                break
            }
            
        }
        
        if wondercopyWondersNum > 1 {
            finalNotesText = wonderCopyList + "\ncannot be neighbours\n"
            if incompatibleWondersNum > 0 {
                finalNotesText += "and cannot be neighbours with:\n" + incompatibleList + "\n"
            }
        } else if wondercopyWondersNum == 1 {
            if incompatibleWondersNum > 0 {
                finalNotesText = wonderCopyList + "\ncannot be neighbours with:\n" + incompatibleList + "\n"
            }
        }
        
        if requiresDice {
            finalNotesText += "6-sided Dice required\n"
        }
        if removeMidas {
            finalNotesText += "remove Midas from the Leaders Deck\n"
        }
        if removeAlexander {
            finalNotesText += "remove Alexander from the Leaders Deck\n"
        }
        if requiresDominionCard {
            finalNotesText += "make sure you have the Dominion Card\n"
        }
        if requiresExtraPurpleCards {
            finalNotesText += "requires 3 extra unused Guild Cards\n"
        }
        if requiresExtraBlackCards {
            finalNotesText += "requires 6 extra unused City Cards, 2 for each era\n"
        }
        
        debugPrint(finalNotesText)
        return finalNotesText
    }
}
