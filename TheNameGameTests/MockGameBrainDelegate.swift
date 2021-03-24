//
//  MockGameBrainDelegate.swift
//  TheNameGameTests
//
//  Created by Lynk on 3/24/21.
//

import XCTest
@testable import TheNameGame

class MockGameBrainDelegate: GameBrainDelegate {
    var score: Int?
    var headshotUpdated: Bool?
    var timerStarted: Bool?
    var name: String?
    
    private var expectation: XCTestExpectation?
    private let testCase: XCTestCase
    
    init(testCase: XCTestCase) {
        self.testCase = testCase
    }

    func expectScore() {
        expectation = testCase.expectation(description: "Expect Score")
    }
    
    func expectHeadshotsUpdated() {
        expectation = testCase.expectation(description: "Expect Headshot Update")
    }
   
    func expectTimerStarted() {
        expectation = testCase.expectation(description: "Expect Timer Started")
    }
    
    func expectNameUpdated() {
        expectation = testCase.expectation(description: "Expect Name Updated")
    }
    
    func headshotsUpdated() {
        if expectation?.description == "Expect Headshot Update" {
            self.headshotUpdated = true
            expectation?.fulfill()
            expectation = nil
        }
    }
    
    func updateNameLabel(_ name: String) {
        if expectation?.description == "Expect Name Updated" {
            self.name = name
            expectation?.fulfill()
            expectation = nil
        }
    }
    
    func gameOver(score: Int) {
        if expectation?.description == "Expect Score" {
            self.score = score
            expectation?.fulfill()
            expectation = nil
        }
    }
    
    func startTimer() {
        if expectation?.description == "Expect Timer Started" {
            self.timerStarted = true
            expectation?.fulfill()
            expectation = nil
        }
    }
}
