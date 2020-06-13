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
    @State var showTemporal = false
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                List {
                    ForEach(playersAndCivs.items) { item in
                        PlayerListCell(viewModel: item)
                    }
                    .onDelete(perform: playersAndCivs.onDelete)
                    .onMove(perform: playersAndCivs.onMove)
                    .deleteDisabled(
                        playersAndCivs.disableDelete
                    )
                    if playersAndCivs.temporalAvailable && showTemporal {
                        TemporalCell(temporalCivChoice: self.playersAndCivs.temporalChoices[0], choiceNum: 1)
                        TemporalCell(temporalCivChoice: self.playersAndCivs.temporalChoices[1], choiceNum: 2)
                    }
                    if !playersAndCivs.notes.isEmpty {
                        NotesCell(notes: self.playersAndCivs.notes)
                    }
                    if playersAndCivs.temporalAvailable && !showTemporal {
                        ActivateTemporalCell(showTemporal: $showTemporal)
                    }
                    
                }
                .navigationBarItems(leading: EditButton(),trailing: settingsOrAdd)
                .environment(\.editMode, $editMode)
                .background(Color.white)
                .listStyle(GroupedListStyle())
                .navigationBarTitle("", displayMode: .inline)
                if !editMode.isEditing {
                    HStack(alignment: .center) {
                        if playersAndCivs.temporalAvailable && !showTemporal {
                            Button("Temporal\nParadox") {
                                self.showTemporal = true
                                self.playersAndCivs.playChronoSound()
                            }
                            .buttonStyle(TemporalButtonStyle())
                        } else {
                            Button("Temporal Paradox") {
                                self.showTemporal = true
                            }
                            .buttonStyle(TemporalButtonStyle())
                            .hidden()
                        }
                        Button("GENERATE") {
                            self.playersAndCivs.generateCivList()
                            self.showTemporal = false
                        }
                        .buttonStyle(GenerateButtonStyle())
                        Spacer()
                        .frame(maxWidth: .infinity)
                    }
                    .padding(2)
                    .border(Color.gray, width: 0.25)
                }
            }
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
