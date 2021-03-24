//
//  MainMenuViewController.swift
//  TheNameGame
//
//  Created by Lynk on 3/24/21.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet weak var buttonWidthAnchor: NSLayoutConstraint!
    @IBOutlet weak var timedButton: GameButton!
    @IBOutlet weak var practiceButton: GameButton!
    @IBOutlet weak var instructionsLabel: UILabel!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        ipadPortraitLayout()
    }
    
    //Additional ui changes for accurate ui with ipad 
    func ipadPortraitLayout() {
        if UIDevice.current.userInterfaceIdiom == .pad && UIDevice.current.orientation.isPortrait {
            buttonWidthAnchor.constant = -(view.bounds.width * 0.4)
            timedButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
            practiceButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
            instructionsLabel.font = UIFont.systemFont(ofSize: 34)
            backgroundImageView.contentMode = .scaleAspectFill
            view.layoutIfNeeded()
        } else if UIDevice.current.userInterfaceIdiom == .pad && UIDevice.current.orientation.isLandscape {
            backgroundImageView.contentMode = .scaleToFill
        }
    }
    
    //Intialize game brain according to the button selected
    //If timed, intialize progress bar
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? GameViewController else { return }
        
        if sender as? UIButton == timedButton {
            destination.gameBrain = GameBrain(.timed)
            destination.progressBar = CircularProgressBar(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 24, height: 24)))
            destination.title = NameGameStrings.timedTitle
        } else {
            destination.gameBrain = GameBrain(.practice)
            destination.title = NameGameStrings.practiceTitle
        }
    }
}
