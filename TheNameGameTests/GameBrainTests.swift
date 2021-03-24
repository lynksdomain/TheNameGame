//
//  GameBrainTests.swift
//  TheNameGameTests
//
//  Created by Lynk on 3/24/21.
//

import XCTest
@testable import TheNameGame

var testProfiles: [Profile]!

class GameBrainTests: XCTestCase {
   
    var score: Int?
    var expectation: XCTestExpectation?
        
    override class func setUp() {
        super.setUp()
        testProfiles = [Profile(firstName: "Alex", lastName: "Paul", headshot: Headshot(url: URL(string: "https://gonintendo.com/uploads/file_upload/upload/75989/hubr.png"))),Profile(firstName: "Alan", lastName: "Holguin", headshot: Headshot(url: URL(string: "https://gonintendo.com/uploads/file_upload/upload/75989/hubr.png"))),Profile(firstName: "Mike", lastName: "Waz", headshot: Headshot(url: URL(string: "https://gonintendo.com/uploads/file_upload/upload/75989/hubr.png"))),Profile(firstName: "Anakin", lastName: "Skywalker", headshot: Headshot(url: URL(string: "https://gonintendo.com/uploads/file_upload/upload/75989/hubr.png"))),Profile(firstName: "Baby", lastName: "Yoda", headshot: Headshot(url: URL(string: "https://gonintendo.com/uploads/file_upload/upload/75989/hubr.png"))),Profile(firstName: "Shinji", lastName: "Ikari", headshot: Headshot(url: URL(string: "https://gonintendo.com/uploads/file_upload/upload/75989/hubr.png")))]
    }
    
    override class func tearDown() {
        testProfiles = nil
        super.tearDown()
    }
    
    func testStartGame() {
        let gameBrain = GameBrain(.practice)
        gameBrain.startGame(testProfiles)
        XCTAssertEqual(gameBrain.getItemCount(), 6)
    }
    
    func testMoveSelected() {
        let gameBrain = GameBrain(.practice)
        let mock = MockGameBrainDelegate(testCase: self)
        gameBrain.delegate = mock
        
        mock.expectScore()
        gameBrain.startGame(testProfiles)
        gameBrain.profileSelected(20)
        
        waitForExpectations(timeout: 5)
        
        do {
        let result = try XCTUnwrap(mock.score)
            XCTAssertEqual(result, 0)
        } catch {
            XCTFail()
        }
    }
    
    func testHeadshotUpdated() {
        let gameBrain = GameBrain(.practice)
        let mock = MockGameBrainDelegate(testCase: self)
        gameBrain.delegate = mock
        
        mock.expectHeadshotsUpdated()
        gameBrain.startGame(testProfiles)
        
        waitForExpectations(timeout: 5)
        
        do {
        let result = try XCTUnwrap(mock.headshotUpdated)
            XCTAssertTrue(result)
        } catch {
            XCTFail()
        }
    }
    
    func testStartTimer() {
        let gameBrain = GameBrain(.timed)
        let mock = MockGameBrainDelegate(testCase: self)
        gameBrain.delegate = mock
        
        mock.expectTimerStarted()
        gameBrain.startGame(testProfiles)
        
        waitForExpectations(timeout: 5)
        
        do {
            let result = try XCTUnwrap(mock.timerStarted)
            XCTAssertTrue(result)
        } catch {
            XCTFail()
        }
    }
    
    func testNameUpdated() {
        let gameBrain = GameBrain(.practice)
        let mock = MockGameBrainDelegate(testCase: self)
        gameBrain.delegate = mock
        
        mock.expectNameUpdated()
        gameBrain.startGame(testProfiles)
        
        waitForExpectations(timeout: 5)
        
        do {
            let result = try XCTUnwrap(mock.name)
            XCTAssertNotNil(result)
        } catch {
            XCTFail()
        }
    }
    
    
    func testURLRetrieval() {
        let gameBrain = GameBrain(.practice)
        gameBrain.startGame(testProfiles)
        let result = gameBrain.getHeadshotUrl(3)
        XCTAssertNotNil(result)
    }
    
    func testCorrectIndex() {
        let gameBrain = GameBrain(.practice)
        let result = gameBrain.selectionIsCorrect(0)
        XCTAssertTrue(result)
    }
    
    func testTimerEnded() {
        let gameBrain = GameBrain(.practice)
        let mock = MockGameBrainDelegate(testCase: self)
        gameBrain.delegate = mock
        
        mock.expectScore()
        gameBrain.timerEnded()
        
        waitForExpectations(timeout: 5)
        
        do {
        let result = try XCTUnwrap(mock.score)
            XCTAssertEqual(result, 0)
        } catch {
            XCTFail()
        }
    }
    
}



