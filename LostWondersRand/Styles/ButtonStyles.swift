//
//  ButtonStyles.swift
//  LostWondersRand
//
//  Created by ThomasPiechula on 29/05/2020.
//  Copyright © 2020 ThomasPiechula. All rights reserved.
//

import SwiftUI

struct TemporalButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
        .padding()
        .font(.headline)
        .background(Color.init(red: 0.2, green: 0.3, blue: 0.5))
        .foregroundColor(Color.white)
        .lineLimit(2)
        .multilineTextAlignment(.center)
        .clipShape(Capsule(style: .continuous) )
        .frame(maxWidth: .infinity)
    }
}

struct GenerateButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
        .padding()
        .font(.headline)
        .background(Color.purple)
        .foregroundColor(Color.white)
        .minimumScaleFactor(0.5)
        .scaledToFill()
        .clipShape(Capsule(style: .continuous) )
        .frame(maxWidth: .infinity)
    }
}
