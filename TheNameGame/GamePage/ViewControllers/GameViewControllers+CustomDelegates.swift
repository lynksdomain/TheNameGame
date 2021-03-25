//
//  GameViewControllers+CustomDelegates.swift
//  TheNameGame
//
//  Created by Lynk on 3/24/21.
//

import UIKit

extension GameViewController: CircularProgressBarDelegate {
    func timerEnded() {
        gameBrain.timerEnded()
    }
}

extension GameViewController: GameBrainDelegate {
    
    func startTimer() {
        progressBar?.startTimer()
    }
    
    
    func gameOver(score: Int) {
        let alert = UIAlertController(title: NameGameStrings.gameOverTitle, message: NameGameStrings.scoreMessage(score), preferredStyle: .alert)
        let ok = UIAlertAction(title: NameGameStrings.ok, style: .default) { [weak self](alert) in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    
    func updateNameLabel(_ name: String) {
        nameLabel.text = name
    }
    
    func headshotsUpdated() {
        headshotCollectionView.reloadData()
    }
}

