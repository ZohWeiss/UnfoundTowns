//
//  Player.swift
//  UnfoundTowns
//
//  Created by Zoh on 7/21/19.
//  Copyright © 2019 Zoh Weiss. All rights reserved.
//

import Foundation

class Player {
    var name: String
    var score = 0
    var expeditions: [ExpeditionColor : Expedition]
    
    init(playerName: String) {
        name = playerName
        expeditions = ExpeditionColor.allCases.reduce(into: [:]) { expeditions, color in
            expeditions[color] = Expedition(color: color)
        }
    }
}
