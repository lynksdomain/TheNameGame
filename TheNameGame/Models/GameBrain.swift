//
//  GameBrain.swift
//  TheNameGame
//
//  Created by Lynk on 3/23/21.
//

import UIKit

enum GameType {
    case practice, timed
}

//Delegate Methods to alert game viewcontroller
protocol GameBrainDelegate: AnyObject {
    func headshotsUpdated()
    func updateNameLabel(_ name:String)
    func gameOver(score:Int)
    func startTimer()
}

class GameBrain {
    private let gameType: GameType
    private var allProfiles = [Profile]()
    private let profileApi = ProfileApi()
    weak var delegate: GameBrainDelegate?
    
    //current game values
    private var currentProfiles = [Profile]() {
        didSet {
            delegate?.headshotsUpdated()
        }
    }
    private var currentProfileIndex = 0 {
        didSet {
            delegate?.updateNameLabel(currentProfiles[currentProfileIndex].fullName)
        }
    }
    
    private var currentScore = 0
    
    
    init(_ gameType: GameType) {
        self.gameType = gameType
        
    }
    
    //Start of game
    //1.Set all profiles
    //2.Load a new round of choices
    //3.If timed, start timer
    
    func startGame(_ profiles:[Profile]) {
        allProfiles = profiles
        newRound()
        if self.gameType == .timed {
            self.delegate?.startTimer()
        }
    }
    
    
    //Player makes selection
    //1. Timer to allow UI to show overlay before switching
    //2.If correct, update score and show new round
    //3.If incorrect and practice mode, end game
    func profileSelected(_ selectedIndex:Int) {
        _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) {[weak self] (timer) in
            guard let self = self else { return }
            if self.selectionIsCorrect(selectedIndex) {
                self.currentScore += 1
                self.newRound()
            } else {
                if self.gameType == .practice {
                    self.delegate?.gameOver(score: self.currentScore)
                }
            }
            timer.invalidate()
        }
    }
    
    //When timer has ended, end game
    func timerEnded() {
        delegate?.gameOver(score: currentScore)
    }
    
    
    //HELPER FUNCTIONS
    func selectionIsCorrect(_ selectedIndex:Int) -> Bool {
        return selectedIndex == currentProfileIndex
    }
    
    private func newRound() {
        currentProfiles = newBatchOfProfiles()
        currentProfileIndex = newProfileIndex()
    }
    
    func getItemCount() -> Int {
        return currentProfiles.count
    }
    
    
    func getHeadshotUrl(_ index: Int) -> URL? {
        return currentProfiles[index].headshot.url
    }
    
    private func newProfileIndex() -> Int {
        return Int.random(in: 0..<currentProfiles.count)
    }
    
    //Creates shadow list of all profiles to randomly remove 6
    //This is done to avoid duplication in new batch
    private func newBatchOfProfiles() -> [Profile] {
        var tempAllProfiles = allProfiles
        var newBatch = [Profile]()
        for _ in 1...6 {
            let randomNumber = Int.random(in: 0..<tempAllProfiles.count)
            let selectedProfile = tempAllProfiles.remove(at: randomNumber)
            newBatch.append(selectedProfile)
        }
        return newBatch
    }
}
