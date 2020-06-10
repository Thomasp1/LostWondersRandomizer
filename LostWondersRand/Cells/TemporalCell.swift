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
        HStack(alignment: .center, spacing: 4) {
            Text("Temporal choice \(choiceNum): ")
            Text(temporalCivChoice)
            .lineLimit(1)
            .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .frame(height: 44)
    }
}

struct TemporalCell_Previews: PreviewProvider {
    static var previews: some View {
        TemporalCell(temporalCivChoice: "A Civ", choiceNum: 1)
    }
}
