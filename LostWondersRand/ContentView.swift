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
            VStack {
                ScrollView {
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
                    HStack {
                        Text("Test \n newline \n another new line jfkdls;ajfklds;ajfkdl;asjfkdlajki")
                            .multilineTextAlignment(.leading)
                            .padding()
                        Spacer()
                    }
                    .hidden()


                }
                .background(Color.white)
                .navigationBarItems(trailing: NavigationLink(destination: SettingsView()){
                    Text("Settings")
                })
                Spacer(minLength: 12)
                HStack(alignment: .center) {
                    Button("Temporal Paradox") {
                        
                    }
                    .padding()
                    .font(.headline)
                    .background(Color.init(red: 0.2, green: 0.3, blue: 0.5))
                    .foregroundColor(Color.white)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .clipShape(Capsule(style: .continuous) )
                    .frame(maxWidth: .infinity)
                    .hidden()
                    Button("GENERATE") {
                        self.playersAndCivs.generateCivs()
                    }
                    .padding()
                    .font(.headline)
                    .background(Color.purple)
                    .foregroundColor(Color.white)
                    .clipShape(Capsule(style: .continuous) )
                    .frame(maxWidth: .infinity)
                    Spacer()
                    .frame(maxWidth: .infinity)
                }
                .padding(2)
                Spacer(minLength: 12)
            }
            .background(Color.init(.lightGray))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let playersAndCivs = PlayersAndCivs()
    static var previews: some View {
        ContentView().environmentObject(playersAndCivs)
    }
}
