//
//  Expedition.swift
//  UnfoundTowns
//
//  Created by Zoh on 7/20/19.
//  Copyright © 2019 Zoh Weiss. All rights reserved.
//

import Foundation

enum ExpeditionColor: CaseIterable {
    case gold
    case green
    case blue
    case white
    case red
    case purple
}

class Expedition {
    static var availableCardValues: Set<Int> = [2, 3, 4, 5, 6, 7, 8, 9, 10]
    static var availableWagers = 3
    
    let color: ExpeditionColor
    var wagers: Int
    var cardValues: Set<Int>
    
    init(color: ExpeditionColor) {
        self.color = color
        self.wagers = 0
        self.cardValues = Set<Int>()
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
    
    func reset() {
        wagers = 0
        Expedition.availableCardValues.formUnion(cardValues)
        cardValues = Set<Int>()
    }
    
    func placeWager() throws {
        guard Expedition.availableWagers > 0, wagers < 4 else {
            throw UnfoundTownError.noAvailableWagers
        }
        
        wagers += 1
        Expedition.availableWagers -= 1
    }
    
    func placeCard(value: Int) throws {
        guard !cardValues.contains(value) else {
            throw UnfoundTownError.valueNotAvailable
        }
        
        if let card = Expedition.availableCardValues.remove(value) {
            cardValues.insert(card)
        } else {
            throw UnfoundTownError.valueNotAvailable
        }
        
    }
}
