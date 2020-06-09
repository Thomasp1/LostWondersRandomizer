//
//  ContentView.swift
//  LostWondersRand
//
//  Created by ThomasPiechula on 07/05/2020.
//  Copyright © 2020 ThomasPiechula. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var playersAndCivs: PlayersAndCivs
    @State var showTemporal = false
    @State private var editMode = EditMode.inactive
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(0..<7) { playerNum in
                        HStack(alignment: .center, spacing: 4) {
                            TextField("Player \(playerNum+1)", text: self.$playersAndCivs.players[playerNum])
                            Text(self.playersAndCivs.civs[playerNum])
                            .lineLimit(1)
                            .fixedSize(horizontal: false, vertical: true)
                        }
                    .padding()
                        .frame(height: 44)
                    }
                    if playersAndCivs.wonderBundles.count > 1 {
                        HStack(alignment: .center, spacing: 4) {
                            TextField("Player 8", text: self.$playersAndCivs.players[7])
                            Text(self.playersAndCivs.civs[7])
                            .lineLimit(1)
                            .fixedSize(horizontal: false, vertical: true)
                        }
                    .padding()
                        .frame(height: 44)
                    }
                    if playersAndCivs.temporalAvailable && showTemporal {
                        HStack(alignment: .center, spacing: 4) {
                            Text("Temporal choice 1: ")
                            Text(self.playersAndCivs.temporalChoices[0])
                            .lineLimit(1)
                            .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding()
                        .frame(height: 44)
                        HStack(alignment: .center, spacing: 4) {
                                Text("Temporal choice 2: ")
                                Text(self.playersAndCivs.temporalChoices[1])
                                .lineLimit(1)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding()
                        .frame(height: 44)
                    }
                    if !self.playersAndCivs.notes.isEmpty {
                        HStack {
                            Text(self.playersAndCivs.notes)
                                .multilineTextAlignment(.leading)
                                .padding()
                        }
                    }


                }
                .background(Color.white)
                .listStyle(GroupedListStyle())
                .environment(\.editMode, $editMode)
                .navigationBarItems(
                    leading:
                    HStack {
                        EditButton()
                        addButton
                    },
                                    trailing:
                    NavigationLink(destination: SettingsView()){
                        Text("Settings")
                    }
                )
                Spacer(minLength: 12)
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
                        self.playersAndCivs.generateCivs()
                        self.showTemporal = false
                    }
                    .buttonStyle(GenerateButtonStyle())
                    Spacer()
                    .frame(maxWidth: .infinity)
                }
                .padding(2)
                Spacer(minLength: 12)
            }
            .background(Color.init(.lightGray))
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
        
    }
    private func onDelete(offsets: IndexSet) {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static let playersAndCivs = PlayersAndCivs()
    static var previews: some View {
        ContentView().environmentObject(playersAndCivs)
    }
}

