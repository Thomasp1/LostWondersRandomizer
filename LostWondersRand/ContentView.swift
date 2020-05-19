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
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(0..<7) { playerNum in
                    HStack(alignment: .center, spacing: 4) {
                        TextField("Player \(playerNum+1)", text: self.$playersAndCivs.players[playerNum])
                        Text(self.playersAndCivs.civs[playerNum])
                        .lineLimit(1)
                        .fixedSize(horizontal: false, vertical: true)
                    }
                .padding(12)
                }
                if playersAndCivs.wonderBundles.count > 1 {
                    HStack(alignment: .center, spacing: 4) {
                        TextField("Player 8", text: self.$playersAndCivs.players[7])
                        Text(self.playersAndCivs.civs[7])
                        .lineLimit(1)
                        .fixedSize(horizontal: false, vertical: true)
                    }
                .padding(12)
                }
                Spacer()
                Button("GENERATE") {
                    self.playersAndCivs.civs = Generator.generate(playerNum: 5, bundles:
                        self.playersAndCivs.wonderBundles, teams: self.playersAndCivs.teams)
                }
                .padding()
                .font(.headline)
                .background(Color.purple)
                .foregroundColor(Color.white)
                .clipShape(Capsule(style: .continuous) )
                Spacer().frame(height: 12)


            }
            .navigationBarItems(trailing: NavigationLink(destination: SettingsView()){
                Text("Settings")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let playersAndCivs = PlayersAndCivs()
    static var previews: some View {
        ContentView().environmentObject(playersAndCivs)
    }
}
