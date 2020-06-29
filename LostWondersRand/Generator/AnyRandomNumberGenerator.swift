//
//  AnyRandomNumberGenerator.swift
//  LostWondersRand
//
//  Created by ThomasPiechula on 29/06/2020.
//  Copyright © 2020 ThomasPiechula. All rights reserved.
//

import Foundation

struct AnyRandomNumberGenerator: RandomNumberGenerator {
    private var generator: RandomNumberGenerator
    
    init(_ generator: RandomNumberGenerator) {
        self.generator = generator
    }
    
    mutating func next() -> UInt64 {
        return self.generator.next()
    }
    
    public mutating func next<T>() -> T where T : FixedWidthInteger, T : UnsignedInteger {
        return self.generator.next()
    }
    
    public mutating func next<T>(upperBound: T) -> T where T : FixedWidthInteger, T : UnsignedInteger {
        return self.generator.next(upperBound: upperBound)
    }
}
