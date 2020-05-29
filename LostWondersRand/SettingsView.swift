//
//  SettingsView.swift
//  LostWondersRand
//
//  Created by ThomasPiechula on 12/05/2020.
//  Copyright © 2020 ThomasPiechula. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var playersAndCivs: PlayersAndCivs
    @State private var toggleTest: Bool = false
    var body: some View {
        Form {
            Section {
                Toggle(isOn: $playersAndCivs.teams.animation()) {
                    Text("Teams")
                }
            }
            Section {
                Toggle(isOn: $playersAndCivs.cities.animation()) {
                    Text("Cities Wonders")
                }
                Toggle(isOn: $playersAndCivs.leaders.animation()) {
                    Text("Leaders Wonders")
                }
                Toggle(isOn: $playersAndCivs.wonderpack.animation()) {
                    Text("Wonderpack Wonders")
                }
            }
            Section {
                Toggle(isOn: $playersAndCivs.catan.animation()) {
                    Text("Catan Wonder")
                }
                Toggle(isOn: $playersAndCivs.armada.animation()) {
                    Text("Armada Wonder")
                }
            }
            Section {
                Toggle(isOn: $playersAndCivs.lostWonders.animation()) {
                    Text("Lost Wonders")
                }
                Toggle(isOn: $playersAndCivs.lostWonders2.animation()) {
                    Text("Lost Wonders 2")
                }
            }
            Section {
                VStack {
                    HStack {
                        Spacer()
                        Image("Seven_Blunders")
                        Spacer()
                    }
                    Text("Created by Thomas Piechula\nwith special thanks to\nAngelika Postaremczak")
                        .multilineTextAlignment(.center)
                    .padding()
                    
                }
            }
                	
        }
        .navigationBarTitle(Text("Settings"),displayMode: .inline)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static let playersAndCivs = PlayersAndCivs()
    static var previews: some View {
        SettingsView().environmentObject(playersAndCivs)
    }
}
