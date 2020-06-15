//
//  ActivateTemporalCell.swift
//  LostWondersRand
//
//  Created by ThomasPiechula on 12/06/2020.
//  Copyright © 2020 ThomasPiechula. All rights reserved.
//

import SwiftUI

struct ActivateTemporalCell: View {
    @EnvironmentObject var playersAndCivs: PlayersAndCivs
    @Binding var showTemporal: Bool
    @GestureState var highlight = false
    var animationGesture: some Gesture {
        LongPressGesture(minimumDuration: .infinity)
        .updating($highlight) { value, state, transaction in
            transaction.animation = Animation.linear(duration: 6.1)
            state = true
        }
    }
    
    var body: some View {
        Text("Activate Temporal Paradox")
            .background(Color.clear)
            .font(.headline)
            .foregroundColor(Color.white)
            .lineLimit(2)
            .multilineTextAlignment(.center)
            .onLongPressGesture(minimumDuration: 6.1, pressing: { inProgress in
                debugPrint("In Progress; \(inProgress)")
                if inProgress {
                    self.playersAndCivs.playLongChrono()
                } else {
                    self.playersAndCivs.stopSounds()
                }
            }) {
                debugPrint("long pressed!")
                self.playersAndCivs.playChronoSound()
                self.showTemporal = true
            }
            .simultaneousGesture(animationGesture)
            .listRowBackground(
                self.highlight ? Color.init(red: 0.0, green: 1.0, blue: 1.0) :
                Color.init(red: 0.2, green: 0.3, blue: 0.5)
            )
    }
}

struct ActivateTemporalCell_Previews: PreviewProvider {
    static let playersAndCivs = PlayersAndCivs()
    static var previews: some View {
        ActivateTemporalCell(showTemporal: .constant(false)).environmentObject(playersAndCivs)
    }
}
