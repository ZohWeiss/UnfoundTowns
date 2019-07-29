//
//  Player.swift
//  UnfoundTowns
//
//  Created by Zoh on 7/21/19.
//  Copyright © 2019 Zoh Weiss. All rights reserved.
//

import Foundation

class Player {
    private let uuid: UUID
    
    var name: String
    var score: Int
    
    init(name playerName: String) {
        uuid = UUID()
        name = playerName
        score = 0
    }
    
    func updateScore(adding subtotal: Int) {
        score += subtotal
    }
}

extension Player: Hashable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
