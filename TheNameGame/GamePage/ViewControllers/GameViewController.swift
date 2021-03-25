//
//  GameViewController.swift
//  TheNameGame
//
//  Created by Lynk on 3/22/21.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var collectionWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var headshotCollectionView: UICollectionView!
    @IBOutlet weak var nameLabel: UILabel!
    
    let layoutGuide = CollectionLayoutGuide()
    var progressBar: CircularProgressBar?
    var gameBrain: GameBrain!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setDelegatesAndDataSource()
        loadDataAndStartGame()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        setNameLabelAlignment()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        updateNameLabelAlignment(collection: newCollection)
        headshotCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    
    //HELPER FUNCTIONS FOR SET UP
    
    func loadDataAndStartGame() {
        ProfileApi().getProfiles {[weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case let .success(profiles):
                    self?.gameBrain.startGame(profiles)
                case .failure(_):
                    self?.showRetryNetwork()
                }
            }
        }
    }
    
    //allows to try network again or return to main menu
    func showRetryNetwork() {
        let alert = UIAlertController(title: NameGameStrings.errorTitle, message: NameGameStrings.networkUnavailable, preferredStyle: .alert)
        let cancel = UIAlertAction(title: NameGameStrings.cancel, style: .destructive) { [weak self](alert) in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        let ok = UIAlertAction(title: NameGameStrings.ok, style: .default) { [weak self](alert) in
            self?.loadDataAndStartGame()
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func setDelegatesAndDataSource() {
        gameBrain.delegate = self
        headshotCollectionView.dataSource = self
        headshotCollectionView.delegate = self
        if let progressBar = progressBar {
            progressBar.delegate = self
        }
    }
    
    func setNavigationBar() {
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        if let progressBar = progressBar {
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: progressBar)
            progressBar.delegate = self
        }
    }
    
    func updateNameLabelAlignment(collection: UITraitCollection) {
        
        if collection.verticalSizeClass == .compact && collection.horizontalSizeClass == .compact || collection.verticalSizeClass == .compact && collection.horizontalSizeClass == .regular {
            nameLabel.textAlignment = .left
        } else {
            nameLabel.textAlignment = .center
        }
        
    }
    
    func setNameLabelAlignment() {
        if isLandscape() {
            nameLabel.textAlignment = .left
        } else {
            nameLabel.textAlignment = .center
            if UIDevice.current.userInterfaceIdiom == .pad {
                collectionWidthConstraint.constant = -(view.bounds.width * 0.25)
                nameLabel.textAlignment = .center
                nameLabel.font = UIFont.systemFont(ofSize: 58, weight: .semibold)
                view.layoutIfNeeded()
            }
        }
    }
    
    private func isLandscape() -> Bool {
        return traitCollection.verticalSizeClass == .compact && traitCollection.horizontalSizeClass == .compact || traitCollection.verticalSizeClass == .compact && traitCollection.horizontalSizeClass == .regular
    }
   
}
