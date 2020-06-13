//
//  Wonder.swift
//  LostWondersRand
//
//  Created by ThomasPiechula on 12/05/2020.
//  Copyright © 2020 ThomasPiechula. All rights reserved.
//

import Foundation

// MARK: - Wonder
struct Wonder: Codable {
    var requirements: [String]?
    var a, b: WonderSide

    enum CodingKeys: String, CodingKey {
        case requirements = "Requirements"
        case a = "A"
        case b = "B"
    }
}

// MARK: - WonderSide
struct WonderSide: Codable {
    var resource: String
    var theme: [String]
}
