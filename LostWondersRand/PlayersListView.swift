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
    @State private var editMode = EditMode.inactive
    var body: some View {
        NavigationView {
            List {
                ForEach(playersAndCivs.items) { item in
                    PlayerListCell(viewModel: item)
                }
                .onDelete(perform: playersAndCivs.onDelete)
                .onMove(perform: playersAndCivs.onMove)
                .deleteDisabled(
                    playersAndCivs.disableDelete
                )
            }
            .navigationBarItems(
                leading:
                EditButton()
                ,
                trailing:
                settingsOrAdd
            )
            .environment(\.editMode, $editMode)
        }
    }
    
    private var settingsOrAdd: some View {
        switch editMode {
        case .inactive:
            return AnyView(NavigationLink(destination: SettingsView()){ Text("Settings") })
        default:
            return AnyView(Button(action: playersAndCivs.onAdd) { Image(systemName: "plus") })
        }
    }
}


struct PlayersListView_Previews: PreviewProvider {
    static let playersAndCivs = PlayersAndCivs()
    static var previews: some View {
        PlayersListView().environmentObject(playersAndCivs)
    }
}
