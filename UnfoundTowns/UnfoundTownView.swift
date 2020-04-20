//
//  UnfoundTownView.swift
//  UnfoundTowns
//
//  Created by Zoh on 3/29/20.
//  Copyright © 2020 Zoh Weiss. All rights reserved.
//

import SwiftUI

struct UnfoundTownView: View {
    var body: some View {
        VStack {
            HStack {
                ForEach(1...10, id: \.self) { i in
                    UnfoundTownCard(expeditionColor: .purple, cardValue: i, isForeground: i == 10)
                }
            }
            HStack {
                ForEach(1...10, id: \.self) { i in
                    UnfoundTownCard(expeditionColor: .red, cardValue: i, isForeground: i == 10)
                }
            }
            HStack {
                ForEach(1...10, id: \.self) { i in
                    UnfoundTownCard(expeditionColor: .blue, cardValue: i, isForeground: i == 10)
                }
            }
            HStack {
                ForEach(1...10, id: \.self) { i in
                    UnfoundTownCard(expeditionColor: .green, cardValue: i, isForeground: i == 10)
                }
            }
            HStack {
                ForEach(1...10, id: \.self) { i in
                    UnfoundTownCard(expeditionColor: .gold, cardValue: i, isForeground: i == 10)
                }
            }
            HStack {
                ForEach(1...10, id: \.self) { i in
                    UnfoundTownCard(expeditionColor: .white, cardValue: i, isForeground: i == 10)
                }
                
            }
        }
    }
}

struct UnfoundTownView_Previews: PreviewProvider {
    static var previews: some View {
        UnfoundTownView()
    }
}
