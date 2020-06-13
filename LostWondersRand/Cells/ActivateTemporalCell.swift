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
    var longPress: some Gesture {
        LongPressGesture(minimumDuration: 1.5)
            .updating($highlight) { currentstate, gesturestate, transaction in
                transaction.animation = Animation.easeInOut(duration: 1.5)
                gesturestate = currentstate
            }
            .onEnded{_ in
                debugPrint("gesture ended")
                self.playersAndCivs.playChronoSound()
                self.showTemporal = true
            }
    }
    var body: some View {
        Text("Activate Temporal Paradox")
            .font(.headline)
            .foregroundColor(Color.white)
            .background(Color.init(red: 0.2, green: 0.3, blue: 0.5))
            .lineLimit(2)
            .multilineTextAlignment(.center)
            .gesture(longPress)
            .brightness(self.highlight ? 1.0 : 0.0)
            .colorMultiply(self.highlight ? .blue : .white)
            .listRowBackground(Color.init(red: 0.2, green: 0.3, blue: 0.5))
            
        
    }
}

struct ActivateTemporalCell_Previews: PreviewProvider {
    static let playersAndCivs = PlayersAndCivs()
    static var previews: some View {
        ActivateTemporalCell(showTemporal: .constant(false)).environmentObject(playersAndCivs)
    }
}
