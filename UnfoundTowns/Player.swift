//
//  Player.swift
//  UnfoundTowns
//
//  Created by Zoh on 7/21/19.
//  Copyright © 2019 Zoh Weiss. All rights reserved.
//

class Player {
    let expeditions: [ExpeditionColor: AvailableResources]
    
    var name: String
    var score: Int
    
    init(name: String, expeditions: [ExpeditionColor: AvailableResources]) {
        self.expeditions = expeditions
        self.name = name
        self.score = 0
    }
}
