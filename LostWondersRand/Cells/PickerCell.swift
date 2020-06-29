//
//  PickerCell.swift
//  LostWondersRand
//
//  Created by ThomasPiechula on 20/06/2020.
//  Copyright © 2020 ThomasPiechula. All rights reserved.
//

import SwiftUI

struct PickerCell: View {
    @ObservedObject var viewModel: PlayerCivItem
    @State private var pickerTest = 0
    @State private var pickerActive = false
    var pickerList = ["something","nothing","everything"]
    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            TextField(viewModel.name, text:
                Binding<String>(
                    get: {self.viewModel.name},
                    set: {self.viewModel.name = $0})
            )
            if !pickerActive {
                Button(action: {
                    self.pickerActive.toggle()
                }) {
                    Image(systemName: "lock")
                }
            } else {
                Picker(selection: $pickerTest, label: Text("Picker Label")) {
                    ForEach(0 ..< pickerList.count) { arg in
                        Button(action: {
                            self.pickerActive.toggle()
                        }) {
                            Text(self.pickerList[arg])
                        }
                    }
                }
                .pickerStyle(WheelPickerStyle())
            }

        }
    }
}

struct PickerCell_Previews: PreviewProvider {
    static var previews: some View {
        PickerCell(viewModel: PlayerCivItem(name: "Player 1", civ: "Some Civ"))
    }
}
