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
        LongPressGesture(minimumDuration: 6.2)
            .updating($highlight) { currentstate, gesturestate, transaction in
                transaction.animation = Animation.easeInOut(duration: 6.2)
                gesturestate = currentstate
                debugPrint("currentstate: \(currentstate)")
                debugPrint("gesturestate: \(gesturestate)")
                debugPrint("transaction: \(transaction)")
            }
            .onEnded { _ in
                self.playersAndCivs.playChronoSound()
                self.showTemporal = true
                debugPrint("Gesture onEnded")
            }
            .onChanged { _ in
                self.playersAndCivs.playLongChrono()
                debugPrint("Gesture onChanged")
            }
    }
    var cancelPress: some Gesture {
        TapGesture()
            .onEnded { _ in
                self.playersAndCivs.stopSounds()
                debugPrint("tap ended")
            }
    }
    var cancelDrag: some Gesture {
        DragGesture()
            .onEnded { _ in
                self.playersAndCivs.stopSounds()
                debugPrint("drag ended")
            }
    }
    var body: some View {
        Text("Activate Temporal Paradox")
            .font(.headline)
            .foregroundColor(Color.white)
            .lineLimit(2)
            .multilineTextAlignment(.center)
            .gesture(longPress)
            .simultaneousGesture(cancelPress)
            .simultaneousGesture(cancelDrag)
            .listRowBackground(
                self.highlight ? Color.init(red: 0.0, green: 0.5, blue: 0.8) :
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
