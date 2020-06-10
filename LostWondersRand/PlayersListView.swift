//
//  PlayersListView.swift
//  LostWondersRand
//
//  Created by ThomasPiechula on 07/06/2020.
//  Copyright © 2020 ThomasPiechula. All rights reserved.
//

import Foundation
import SwiftUI

class PlayerCivItem: ObservableObject, Identifiable {
    
    @Published var name: String = ""
    @Published var civ: String = ""
    
    init(name: String, civ: String) {
        self.name = name
        self.civ = civ
    }
    
}


struct PlayersListView: View {
    @EnvironmentObject var playersAndCivs: PlayersAndCivs
    @State private var items: [PlayerCivItem] = (0..<5).map { PlayerCivItem(name: "Player \($0)", civ: "civ") }
    @State private var editMode = EditMode.inactive
    private static var count = 0
    
    var body: some View {
        NavigationView {
            List {
                ForEach(playersAndCivs.items) { item in
                    PlayerListCell(viewModel: item)
                }
                .onDelete(perform: onDelete)
                .onMove(perform: onMove)
            }
            .navigationBarItems(leading: EditButton(), trailing: addButton)
            .environment(\.editMode, $editMode)
        }
    }
    
    private var addButton: some View {
        switch editMode {
        case .inactive:
            return AnyView(Button(action: onAdd) { Image(systemName: "plus") })
        default:
            return AnyView(EmptyView())
        }
    }
    
    func onAdd() {
        items.append(PlayerCivItem(name: "Player \(Self.count)", civ: "civ"))
        Self.count += 1
    }
    
    private func onDelete(offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    private func onMove(source: IndexSet, destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }
}


struct PlayersListView_Previews: PreviewProvider {
    static let playersAndCivs = PlayersAndCivs()
    static var previews: some View {
        PlayersListView().environmentObject(playersAndCivs)
    }
}
