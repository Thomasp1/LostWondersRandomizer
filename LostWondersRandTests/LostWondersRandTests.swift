//
//  LostWondersRandTests.swift
//  LostWondersRandTests
//
//  Created by ThomasPiechula on 07/05/2020.
//  Copyright © 2020 ThomasPiechula. All rights reserved.
//

import XCTest
@testable import LostWondersRand

class LostWondersRandTests: XCTestCase {
    
    var sut: PlayersAndCivs!
    
    override func setUp() {
        super.setUp()
        sut = PlayersAndCivs()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testGeneratorTestCivAmount() {
        let wonderBundles: Set = [WonderBundle.original,WonderBundle.cities]
        for playerNum in 3...8 {
            let (civs,_) = Generator.generate(playerNum: playerNum, bundles: wonderBundles, teams: false, startingResourceFilter: false, cardColorFilter: false)
            let civCount = civs.filter { $0 != "" }.count
            XCTAssert(civCount == playerNum, "different civ count than players civCount: \(civCount) playerNum: \(playerNum)")
        }
    }

}
