//
//  PlayerListCell.swift
//  LostWondersRand
//
//  Created by ThomasPiechula on 10/06/2020.
//  Copyright © 2020 ThomasPiechula. All rights reserved.
//

import SwiftUI

struct PlayerListCell: View {
    @ObservedObject var viewModel: PlayerCivItem
    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            TextField(viewModel.name, text:
                Binding<String>(
                    get: {self.viewModel.name},
                    set: {self.viewModel.name = $0})
            )
            Text(viewModel.civ)
            .lineLimit(1)
            .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct PlayerListCell_Previews: PreviewProvider {
    static var previews: some View {
        PlayerListCell(viewModel: PlayerCivItem(name: "Player 1", civ: "Some Civ"))
    }
}
