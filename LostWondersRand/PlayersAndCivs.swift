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
}
