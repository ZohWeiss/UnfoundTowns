//
//  Player.swift
//  UnfoundTowns
//
//  Created by Zoh on 7/21/19.
//  Copyright © 2019 Zoh Weiss. All rights reserved.
//

import Foundation

class Player: Hashable {
    var name: String
    var score: Int
    
    init(name: String) {
        self.name = name
        score = 0
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(UUID())
    }
    
    func updateScore(adding subtotal: Int) {
        score += subtotal
    }
}

extension Player: Equatable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.name == rhs.name
    }
}
