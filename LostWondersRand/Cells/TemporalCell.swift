//
//  TemporalCell.swift
//  LostWondersRand
//
//  Created by ThomasPiechula on 10/06/2020.
//  Copyright © 2020 ThomasPiechula. All rights reserved.
//

import SwiftUI

struct TemporalCell: View {
    var temporalCivChoice: String
    var choiceNum: Int
    var body: some View {
        HStack(spacing: 4) {
            Text("Temporal choice \(choiceNum): ")
            .frame(maxWidth: .infinity, alignment: .leading)
            .fixedSize(horizontal: false, vertical: true)
            Text(temporalCivChoice)
            .lineLimit(1)
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .frame(height: 44)
        .frame(maxWidth: .infinity)
    }
}

struct TemporalCell_Previews: PreviewProvider {
    static var previews: some View {
        TemporalCell(temporalCivChoice: "A Civ", choiceNum: 1)
    }
}
