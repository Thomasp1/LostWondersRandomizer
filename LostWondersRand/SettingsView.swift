//
//  SettingsView.swift
//  LostWondersRand
//
//  Created by ThomasPiechula on 12/05/2020.
//  Copyright © 2020 ThomasPiechula. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @State private var toggleTest: Bool = false
    var body: some View {
        Form {
            Section {
                Toggle(isOn: $toggleTest.animation()) {
                    Text("Teams")
                }
            }
            Section {
                Toggle(isOn: $toggleTest.animation()) {
                    Text("Cities Wonders")
                }
                Toggle(isOn: $toggleTest.animation()) {
                    Text("Leaders Wonders")
                }
                Toggle(isOn: $toggleTest.animation()) {
                    Text("Wonderpack Wonders")
                }
            }
            Section {
                Toggle(isOn: $toggleTest.animation()) {
                    Text("Catan Wonder")
                }
                Toggle(isOn: $toggleTest.animation()) {
                    Text("Armada Wonder")
                }
            }
            Section {
                Toggle(isOn: $toggleTest.animation()) {
                    Text("Lost Wonders")
                }
                Toggle(isOn: $toggleTest.animation()) {
                    Text("Lost Wonders 2")
                }
            }
        }
        .navigationBarTitle(Text("Settings"),displayMode: .inline)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
