//
//  UIViewController+FromToChecker.swift
//  JibSpaceX
//
//  Created by Ibrahim Beltagy on 14/02/2021.
//  Copyright © 2021 Ibrahim Beltagy. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// checkPoppedBackFromVCToVC
    /// - Parameters:
    ///   - fromControllerType: the view controller you are coming from
    ///   - toControllerType: the view controller you are going to / going back to
    func checkPoppedBackFromVCToVC<T: UIViewController, T2: UIViewController>(fromControllerType: T.Type, toControllerType: T2.Type) -> Bool {
        
        if let transitionCoordinator = navigationController?.transitionCoordinator,
            let fromVC = transitionCoordinator.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionCoordinator.viewController(forKey: UITransitionContextViewControllerKey.to),
            fromVC is T,
            toVC is T2 {
            return true
        } else {
            return false
        }
    }
    
}
