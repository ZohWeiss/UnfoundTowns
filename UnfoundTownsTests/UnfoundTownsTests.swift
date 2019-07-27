//
//  UnfoundTownsTests.swift
//  UnfoundTownsTests
//
//  Created by Zoh on 7/20/19.
//  Copyright © 2019 Zoh Weiss. All rights reserved.
//

import XCTest
@testable import UnfoundTowns

class UnfoundTownsTests: XCTestCase {

    func testMaxScore() {
        let expedition = Expedition()
        expedition.cardValues = [2, 3, 4, 5, 6, 7, 8, 9, 10]
        expedition.wagers = 3
        XCTAssertEqual(expedition.score, 156, "Max score is incorrect")
    }
    
    func testMinScore() {
        let expedition = Expedition()
        XCTAssertEqual(expedition.score, 0, "Min score is incorrect")
    }
    
    func testBonus() {
        let expedition = Expedition()
        expedition.wagers = 3
        XCTAssertFalse(expedition.hasBonus, "Expedition should not have bonus")
        XCTAssertEqual(expedition.score, -80, "Score calculated incorrectly")
        
        expedition.cardValues = [2, 3, 4, 5]
        XCTAssertFalse(expedition.hasBonus, "Expedition should not have bonus")
        XCTAssertEqual(expedition.score, -24, "Score calculated incorrectly")
        
        expedition.cardValues.insert(6)
        XCTAssert(expedition.hasBonus, "Expedition should have bonus")
        XCTAssertEqual(expedition.score, 20, "Score calculated incorrectly")
    }

    func testReset() {
        let expedition = Expedition()
        for i in 2...10 {
            try! expedition.placeCard(value: i)
        }
        expedition.wagers = 3
        
        XCTAssert(expedition.expeditionStarted, "Expedition not started")
        XCTAssert(expedition.hasBonus, "Expedition does not have bonus")
        XCTAssert(expedition.availableCardValues.isEmpty, "Incorrect available card values")
        XCTAssertEqual(expedition.score, 156, "Max score is incorrect")
        XCTAssertEqual(expedition.cardCount, 12, "Incorrect number of cards before reset")
        
        expedition.reset()
        
        XCTAssertFalse(expedition.expeditionStarted, "Expedition still started after reset")
        XCTAssertFalse(expedition.hasBonus, "Bonus did not reset")
        XCTAssertEqual(expedition.wagers, 0, "Wagers not reset")
        XCTAssertEqual(expedition.score, 0, "Min score is incorrect")
        XCTAssertEqual(expedition.cardCount, 0, "Card count not reset")
        XCTAssert(expedition.cardValues.isEmpty, "Card values not emptied")
        XCTAssertEqual(expedition.availableCardValues, [2, 3, 4, 5, 6, 7, 8, 9, 10], "Incorrect available card values after reset")
    }
    
    func testPlayers() {
        let playerName1 = "Player 1"
        let playerName2 = "Player 2"
        
        let player1 = Player(playerName: playerName1)
        let player2 = Player(playerName: playerName2)
        
        XCTAssertEqual(player1.name, playerName1, "Player 1 name is incorrect")
        XCTAssertEqual(player2.name, playerName2, "Player 2 name is incorrect")
//        XCTAssertEqual(player1.expeditions.count, 6, "Player 1 Expedition Count is incorrect")
//        XCTAssertEqual(player2.expeditions.count, 6, "Player 2 Expedition Count is incorrect")
        
//        for color in ExpeditionColor.allCases {
//            XCTAssert(player1.expeditions[color] != nil, "\(color) does not exist in Player 1 expeditions")
//            XCTAssert(player2.expeditions[color] != nil, "\(color) does not exist in Player 2 expeditions")
//        }
    }
}
