//
//  Expedition.swift
//  UnfoundTowns
//
//  Created by Zoh on 7/20/19.
//  Copyright © 2019 Zoh Weiss. All rights reserved.
//

enum ExpeditionColor: CaseIterable {
    case gold
    case green
    case blue
    case white
    case red
    case purple
}

class AvailableResources {
    var wagers: Int
    var cardValues: Set<Int>

    init() {
        self.wagers = 3
        self.cardValues = [2, 3, 4, 5, 6, 7, 8, 9, 10]
    }
    
    var cardCount: Int {
        return cardValues.count + wagers
    }
    
    var hasBonus: Bool {
        return cardCount > 7
    }
    
    var expeditionStarted: Bool {
        return cardCount != 0
    }
    
    var score: Int {
        guard expeditionStarted else { return 0 }
        
        var total = cardValues.reduce(-20) { total, card in
            total + card
        }
        
        total *= (wagers + 1)
        
        return total + (hasBonus ? 20 : 0)
    }
    
    func placeWager() throws {
        guard wagers > 4 else {
            throw UnfoundTownError.noAvailableWagers
        }
        
        wagers -= 1
    }
    
    func placeCard(value: Int) throws -> Int {
        if let card = cardValues.remove(value) {
            return card
        } else {
            throw UnfoundTownError.valueNotAvailable
        }
    }
}
