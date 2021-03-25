//
//  GameViewController+CollectionView.swift
//  TheNameGame
//
//  Created by Lynk on 3/24/21.
//

import UIKit

//All CollectionView Delegate Methods

extension GameViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? HeadshotCell else { return }
        cell.setOverlay(correct: gameBrain.selectionIsCorrect(indexPath.row))
        gameBrain.profileSelected(indexPath.row)
    }
}


//DATA SOURCE
extension GameViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameBrain.getItemCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NameGameStrings.headshotReuseIdentifier, for: indexPath) as? HeadshotCell else { return UICollectionViewCell() }
        cell.setHeadshot(gameBrain.getHeadshotUrl(indexPath.row))
        cell.clearOverlay()
        return cell
    }
    
}


//LAYOUT
extension GameViewController: UICollectionViewDelegateFlowLayout {
    //Math for select columns
    //1.Get margins and Insets in a row for amount of columns
    //2.Get width from  collection width without margins and insets divided by # of columns
    //3.Get square cells returning cgsize with width == height
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let marginsAndInsets = layoutGuide.getInset() * layoutGuide.numberOfColumns() + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + layoutGuide.getInset() * CGFloat(layoutGuide.numberOfColumns() - 1.0)
        let width = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(layoutGuide.numberOfColumns()))
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return layoutGuide.getMinLineSpacing()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return layoutGuide.getMinInteritemSpacing()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return layoutGuide.getEdgeInsets()
    }
}
