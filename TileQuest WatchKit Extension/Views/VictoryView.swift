//
//  VictoryView.swift
//  TileQuest WatchKit Extension
//
//  Created by Mirosław Błażej on 24/10/2020.
//

import SwiftUI

struct VictoryView: View {
    let onPlayAgain: () -> ()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Victory!")
            Button(action: onPlayAgain, label: {
                Text("Play again")
            }).background(Color.black)
        }
        .padding(5)
        .background(Color.black.opacity(0.75))
    }
}

struct VictoryView_Previews: PreviewProvider {
    static var previews: some View {
        VictoryView(onPlayAgain: {})
    }
}
