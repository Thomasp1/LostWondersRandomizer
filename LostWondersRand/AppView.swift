//
//  AppView.swift
//  LostWondersRand
//
//  Created by ThomasPiechula on 10/06/2020.
//  Copyright © 2020 ThomasPiechula. All rights reserved.
//

import SwiftUI

struct AppView: View {
    @EnvironmentObject var playersAndCivs: PlayersAndCivs
    var body: some View {
        PlayersListView()
    }
}

struct AppView_Previews: PreviewProvider {
    static let playersAndCivs = PlayersAndCivs()
    static var previews: some View {
        AppView().environmentObject(playersAndCivs)
    }
}
