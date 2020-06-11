//
//  NotesCell.swift
//  LostWondersRand
//
//  Created by ThomasPiechula on 10/06/2020.
//  Copyright © 2020 ThomasPiechula. All rights reserved.
//

import SwiftUI

struct NotesCell: View {
    var notes: String
    var body: some View {
        HStack {
            Text(notes)
                .multilineTextAlignment(.leading)
                .padding()
        }
    }
}

struct NotesCell_Previews: PreviewProvider {
    static var previews: some View {
        NotesCell(notes: "bla bla \n more bla")
    }
}
