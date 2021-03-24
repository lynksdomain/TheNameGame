//
//  NavViewController.swift
//  TheNameGame
//
//  Created by Lynk on 3/22/21.
//

import UIKit

class NavViewController: UINavigationController {
    
    //because apple hates developers working on the ipad
    //jk handles size classes for ipad being the same. ie regular regular for both portrait and landscape
    //sets ipad portrait to width: Compact, height: Regular
    override func overrideTraitCollection(forChild childViewController: UIViewController) -> UITraitCollection? {
        if view.bounds.width < view.bounds.height {
                   return UITraitCollection(horizontalSizeClass: .compact)
               } else {
                   return UITraitCollection(horizontalSizeClass: .regular)
               }
    }

}
