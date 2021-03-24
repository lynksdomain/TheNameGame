//
//  ContainerViewController.swift
//  TheNameGame
//
//  Created by Lynk on 3/22/21.
//

import UIKit

class ContainerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func overrideTraitCollection(forChild childViewController: UIViewController) -> UITraitCollection? {
        if view.bounds.width < view.bounds.height {
            return UITraitCollection(horizontalSizeClass: .compact)
                } else {
                    return UITraitCollection(horizontalSizeClass: .regular)
                }
    }

}
