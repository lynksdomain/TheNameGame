//
//  CollectionLayoutGuide.swift
//  TheNameGame
//
//  Created by Lynk on 3/22/21.
//

import UIKit

//Values to design GameViewController's collection view flow layout
struct CollectionLayoutGuide {
    private let inset: CGFloat = 20
    private let minLineSpacing: CGFloat = 20
    private let minInteritemSpacing: CGFloat = 10
    
    func getEdgeInsets() -> UIEdgeInsets {
            return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func getMinLineSpacing() -> CGFloat {
        return minLineSpacing
    }
    
    func getMinInteritemSpacing() -> CGFloat {
        return minInteritemSpacing
    }
    
    func getInset() -> CGFloat{
        return inset
    }
    
    func numberOfColumns() -> CGFloat {
        guard let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation else { return 2.0}
        if orientation == .landscapeLeft || orientation == .landscapeRight {
            return 3.0
        } else {
            return 2.0
        }
    }
    
}



