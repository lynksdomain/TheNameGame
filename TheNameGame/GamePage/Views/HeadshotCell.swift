//
//  HeadshotCell.swift
//  TheNameGame
//
//  Created by Lynk on 3/22/21.
//

import UIKit
import Kingfisher

class HeadshotCell: UICollectionViewCell {
    @IBOutlet weak var HeadshotImageView: UIImageView!
    @IBOutlet weak var overlayImageView: UIImageView!
    
    
    func setHeadshot(_ url: URL?) {
        guard let url = url else { return }
        HeadshotImageView.kf.indicatorType = .activity
        HeadshotImageView.kf.setImage(with: url)
        
        HeadshotImageView.contentMode = .scaleAspectFit
    }
    
    func clearOverlay() {
        overlayImageView.image = nil
    }
    
    func setOverlay(correct: Bool) {
        if correct {
            overlayImageView.contentMode = .scaleToFill
            overlayImageView.image = UIImage(named: NameGameStrings.correctImageFileName)
        } else {
            overlayImageView.image = UIImage(named: NameGameStrings.incorrectImageFileName)
        }
    }
}
