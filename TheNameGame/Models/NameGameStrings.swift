//
//  NameGameStrings.swift
//  TheNameGame
//
//  Created by Lynk on 3/24/21.
//

import Foundation

//Strings used throughout application
struct NameGameStrings {
    static let timedTitle = "Timed Mode"
    static let practiceTitle = "Practice Mode"
    static let headshotReuseIdentifier = "headshotCell"
    static let cancel = "Cancel"
    static let ok = "Ok"
    static let retry = "Retry"
    static let errorTitle = "Error"
    static let networkUnavailable = "Network is unavailable"
    static let gameOverTitle = "Game Over!"
    static let correctImageFileName = "correct"
    static let incorrectImageFileName = "incorrect"

    static func scoreMessage(_ score: Int) -> String {
        return "You got \(score) correct"
    }
}
