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
                ForEach(0..<8) { playerNum in
                    HStack {
                        TextField("Player \(playerNum+1)", text: self.$playersAndCivs.players[playerNum])
                        Text(self.playersAndCivs.civs[playerNum])
                    }
                .padding()
                }
                Spacer().frame(height: 100)
                Button("GENERATE") {
                    self.playersAndCivs.civs = Generator.generate(playerNum: 5)
                }
                .padding()
                .font(.headline)
                .background(Color.purple)
                .foregroundColor(Color.white)
                .clipShape(Capsule(style: .continuous) )


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
