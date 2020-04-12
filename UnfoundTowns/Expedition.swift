//
//  Expedition.swift
//  UnfoundTowns
//
//  Created by Zoh on 7/28/19.
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
    var availableCardValues: Set<Int>
    var availableWagers: Int
    var placedCardValues = [Player: Set<Int>]()
    var placedWagers = [Player: Int]()
        
    init(player1: Player, player2: Player) {
        availableCardValues = [2,3,4,5,6,7,8,9,10]
        availableWagers = 3
        placedCardValues[player1] = Set<Int>()
        placedCardValues[player2] = Set<Int>()
        placedWagers[player1] = 0
        placedWagers[player2] = 0
    }
    
    func calculateScore(_ player: Player) -> Int {
        guard didStartExpedition(player) else { return 0 }
        
        var total = placedCardValues[player]!.reduce(-20) { total, card in
            total + card
        }
        
        total *= (placedWagers[player]! + 1)
        
        return total + (hasBonus(player) ? 20 : 0)
        
    }
    
    func cardCount(_ player: Player) -> Int {
        return placedCardValues[player]!.count + placedWagers[player]!
    }
    
    func didStartExpedition(_ player: Player) -> Bool {
        return cardCount(player) != 0
    }

    func hasBonus(_ player: Player) -> Bool {
        return cardCount(player) > 7
    }
    
    func placeCard(_ player: Player, value: Int) throws {
        guard let card = availableCardValues.remove(value) else {
            throw UnfoundTownError.valueNotAvailable
        }
        
        placedCardValues[player]!.insert(card)
    }
    
    func placeWager(_ player: Player) throws {
        guard availableWagers > 0 else {
            throw UnfoundTownError.noAvailableWagers
        }
        
        availableWagers -= 1
        placedWagers[player]! += 1
    }
}
