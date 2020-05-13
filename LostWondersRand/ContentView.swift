//
//  ContentView.swift
//  LostWondersRand
//
//  Created by ThomasPiechula on 07/05/2020.
//  Copyright © 2020 ThomasPiechula. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var playerNames = ["","","","","","","",""]
    @State private var chosenCivs = ["","","","","","","",""]
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(0..<8) { playerNum in
                    HStack {
                        TextField("Player \(playerNum+1)", text: self.$playerNames[playerNum])
                        Text(self.chosenCivs[playerNum])
                    }
                .padding()
                }
                Spacer().frame(height: 100)
                Button("GENERATE") {
                    self.chosenCivs = Generator.generate(playerNum: 5)
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
    static var previews: some View {
        ContentView()
    }
}
