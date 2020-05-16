//
//  SetExtension.swift
//  LostWondersRand
//
//  Created by ThomasPiechula on 14/05/2020.
//  Copyright © 2020 ThomasPiechula. All rights reserved.
//

import Foundation

extension Set {
    public mutating func toggle(element: Element) {
        self.contains(element) ? self.remove(element) : self.update(with: element)
    }
}
