//
//  File.swift
//  UnfoundTowns
//
//  Created by Zoh on 7/24/19.
//  Copyright © 2019 Zoh Weiss. All rights reserved.
//

class Game {
    let expeditions: [ExpeditionColor: AvailableResources]
    let player1: Player
    let player2: Player
    
    var round: Int

    init() {
        expeditions = ExpeditionColor.allCases.reduce(into: [:]) { expeditions, color in
            expeditions[color] = AvailableResources()
        }
        player1 = Player(name: "Player 1", expeditions: expeditions)
        player2 = Player(name: "Player 2", expeditions: expeditions)
        round = 1
    }
    
    func winner() throws -> Player {
        guard round == 3 else {
            throw UnfoundTownError.gameNotFinished
        }
        
        return player1.score > player2.score
            ? player1
            : player2
        
    }
}
