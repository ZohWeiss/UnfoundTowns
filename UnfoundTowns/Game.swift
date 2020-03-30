//
//  File.swift
//  UnfoundTowns
//
//  Created by Zoh on 7/24/19.
//  Copyright © 2019 Zoh Weiss. All rights reserved.
//

import Foundation

class Game {
    let player1: Player
    let player2: Player
    let expeditions: [ExpeditionColor: Expedition]
    
    @objc dynamic var round: Int

    init(player1: Player, player2: Player) {
        self.player1 = player1
        self.player2 = player2
        expeditions = ExpeditionColor.allCases.reduce(into: [:]) { expeditionList, color in
            expeditionList[color] = Expedition(player1: player1, player2: player2)
        }
        
        round = 1
    }
    
    /// Returns the winning player, or nil in the event of a draw. Throws if it is not the third round.
    func determineWinner() throws -> Player? {
        guard round == 3 else {
            throw UnfoundTownError.gameNotFinished
        }
        
        guard player1.score != player2.score else {
            return nil
        }

        return player1.score > player2.score ? player1 : player2
    }
    
    func endRound() {
        if round > 3 {
            round = 1
        }
        round += 1
    }
    
    func endGame() -> Player? {
        if round == 3 {
            defer { round = 1 }
            return try! determineWinner()
        }
        return nil
    }
}
