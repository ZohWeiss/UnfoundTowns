//
//  UnfoundTownsTests.swift
//  UnfoundTownsTests
//
//  Created by Zoh on 7/20/19.
//  Copyright © 2019 Zoh Weiss. All rights reserved.
//

import XCTest
@testable import UnfoundTowns

typealias PlayerExpeditions = [ExpeditionColor: (wagers: Int, values: [Int])]

class UnfoundTownsTests: XCTestCase {
    
    var p1: Player!
    var p2: Player!
    var expedition: Expedition!
    
    override func setUp() {
        p1 = Player(name: "Player 1")
        p2 = Player(name: "Player 2")
        expedition = Expedition(player1: p1, player2: p2)
    }
    
    func testGame() {
        let game = Game(player1: p1, player2: p2)
        game.round = 3

        let expeditionsP1: PlayerExpeditions = [
            .gold: (0, [3,7,10]),
            .white: (3, [3,4,6,8,10]),
            .blue: (3, [3,4,6,9]),
            .green: (3, [2,4,6,7,9]),
            .red: (0, [4,7,10]),
            .purple: (0, [])
        ]
        
        let expeditionsP2: PlayerExpeditions = [
            .gold: (2, [2,4,5,6,8,9]),
            .white: (0, []),
            .blue: (0, []),
            .green: (0, [3,5,8,10]),
            .red: (1, [3,6,8,9]),
            .purple: (1, [2,5,8,10])
        ]
        
        expeditionsP1.filter{ $1.wagers > 0 || !$1.values.isEmpty }
            .forEach{ (color, cards: (wagers: Int, values: [Int])) in
                for _ in 0..<cards.wagers {
                    try! game.expeditions[color]!.placeWager(p1)
                }
                for value in cards.values {
                    try! game.expeditions[color]!.placeCard(p1, value: value)
                }
            }
        
        expeditionsP2.filter{ $1.wagers != 0 || !$1.values.isEmpty }
            .forEach{ (color, cards: (wagers: Int, values: [Int])) in
                for _ in 0..<cards.wagers {
                    try! game.expeditions[color]!.placeWager(p2)
                }
                for value in cards.values {
                    try! game.expeditions[color]!.placeCard(p2, value: value)
                }
            }
        
        for color in ExpeditionColor.allCases {
            p1.updateScore(adding: game.expeditions[color]!.calculateScore(p1))
            p2.updateScore(adding: game.expeditions[color]!.calculateScore(p2))
        }
        
        XCTAssertEqual(p1.score, 125, "Unexpected score recieved for Player 1")
        XCTAssertEqual(p2.score, 90, "Unexpected score recieved for Player 1")
        XCTAssertEqual(try! game.determineWinner(), p1, "Failed to determine correct winner")
    }

    func testMaxScore() {
        expedition.placedCardValues[p1] = [2, 3, 4, 5, 6, 7, 8, 9, 10]
        expedition.placedWagers[p1] = 3
        XCTAssertEqual(expedition.calculateScore(p1), 156, "Max score is incorrect")
    }
    
    func testMinScore() {
        XCTAssertEqual(expedition.calculateScore(p1), 0, "Min score is incorrect")
    }
    
    func testBonus() {
        expedition.placedWagers[p1] = 3
        XCTAssertFalse(expedition.hasBonus(p1), "Expedition should not have bonus")
        XCTAssertEqual(expedition.calculateScore(p1), -80, "Score calculated incorrectly")

        expedition.placedCardValues[p1] = [2, 3, 4, 5]
        XCTAssertFalse(expedition.hasBonus(p1), "Expedition should not have bonus")
        XCTAssertEqual(expedition.calculateScore(p1), -24, "Score calculated incorrectly")

        expedition.placedCardValues[p1]!.insert(6)
        XCTAssert(expedition.hasBonus(p1), "Expedition should have bonus")
        XCTAssertEqual(expedition.calculateScore(p1), 20, "Score calculated incorrectly")
    }

    func testReinitialization() {
        for i in 2...10 {
            try! expedition.placeCard(p1, value: i)
        }
        
        for _ in 1...3 {
            try! expedition.placeWager(p1)
        }

        XCTAssert(expedition.didStartExpedition(p1), "Expedition not started")
        XCTAssert(expedition.hasBonus(p1), "Expedition does not have bonus")
        XCTAssert(expedition.availableCardValues.isEmpty, "Incorrect available card values")
        XCTAssertEqual(expedition.availableWagers, 0, "Wagers still available after placement")
        XCTAssertEqual(expedition.calculateScore(p1), 156, "Max score is incorrect")
        XCTAssertEqual(expedition.cardCount(p1), 12, "Incorrect number of cards before reset")

        expedition = Expedition(player1: p1, player2: p2)

        XCTAssertFalse(expedition.didStartExpedition(p1), "Expedition still started after reset")
        XCTAssertFalse(expedition.hasBonus(p1), "Bonus did not reset")
        XCTAssertEqual(expedition.placedWagers[p1]!, 0, "Wagers not reset")
        XCTAssertEqual(expedition.calculateScore(p1), 0, "Min score is incorrect")
        XCTAssertEqual(expedition.cardCount(p1), 0, "Card count not reset")
        XCTAssert(expedition.placedCardValues[p1]!.isEmpty, "Card values not emptied")
        XCTAssertEqual(expedition.availableCardValues, [2, 3, 4, 5, 6, 7, 8, 9, 10], "Incorrect available card values after reset")
    }

    func testPlayers() {
        let playerName1 = "Zoh"
        let playerName2 = "Stephanie"

        p1 = Player(name: playerName1)
        p2 = Player(name: playerName2)

        XCTAssertEqual(p1.name, playerName1, "Player 1 name is incorrect")
        XCTAssertEqual(p2.name, playerName2, "Player 2 name is incorrect")
    }
    
    func testPlayerHashability() {
        let setUniqueNames: Set<Player> = [p1, p2]
        XCTAssert(setUniqueNames.count == 2)
        XCTAssert(p1 != p2)
        
        p2 = Player(name: "Player 1")
        var setDuplicateNames: Set<Player> = [p1]
        setDuplicateNames.insert(p2)
        XCTAssert(p1.name == p2.name)
        XCTAssert(setDuplicateNames.count == 2, "Expected count: 2. Actual count: \(setDuplicateNames.count)")
    }
    
}
