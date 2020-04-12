//
//  UnfoundTownRow.swift
//  UnfoundTowns
//
//  Created by Zoh on 3/29/20.
//  Copyright © 2020 Zoh Weiss. All rights reserved.
//

import SwiftUI

func getColorForCard(for expedition: ExpeditionColor) -> Color {
    switch expedition {
    case .purple:
        return .purple
    case .blue:
        return .blue
    case .gold:
        return .yellow
    case .green:
        return .green
    case .red:
        return .red
    case .white:
        return .gray
    }
}

struct UnfoundTownCard: View {
    let expeditionColor: ExpeditionColor
    let cardValue: Int
    let isForeground: Bool

    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .frame(width: 40.0, height: 60.0, alignment: .leading)
            .foregroundColor(getColorForCard(for: expeditionColor))
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.black, lineWidth: 2)
            )
            .overlay(
                Text("\(cardValue)")
                    .font(.system(size: isForeground ? 30 : 16))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.leading, isForeground ? 0 : -16)
                    .padding(.top, isForeground ? 0 : -28)
            )
            .padding(.trailing, -15)
            .padding(.leading, -15)
    }
}

struct UnfoundTownRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HStack {
                UnfoundTownCard(expeditionColor: .gold, cardValue: 2, isForeground: false)
                UnfoundTownCard(expeditionColor: .red, cardValue: 4, isForeground: false)
                UnfoundTownCard(expeditionColor: .blue, cardValue: 6, isForeground: false)
                UnfoundTownCard(expeditionColor: .green, cardValue: 7, isForeground: false)
                UnfoundTownCard(expeditionColor: .white, cardValue: 8, isForeground: false)
                UnfoundTownCard(expeditionColor: .purple, cardValue: 9, isForeground: true)
            }.padding(.bottom, 20)
            
            HStack {
                ForEach(1...10, id: \.self) { i in
                    UnfoundTownCard(expeditionColor: .purple, cardValue: i, isForeground: i == 10)
                }
            }
        }
    }
}
