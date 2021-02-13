//
//  UITableView+ActivityIndicator.swift
//  JibSpaceX
//
//  Created by Ibrahim Beltagy on 14/02/2021.
//  Copyright © 2021 Ibrahim Beltagy. All rights reserved.
//

import UIKit

extension UITableView {
    
    func showActivityIndicator() {
        DispatchQueue.main.async {
            let activityView = UIActivityIndicatorView(style: .gray)
            self.backgroundView = activityView
            activityView.startAnimating()
        }
    }

    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.backgroundView = nil
        }
    }

}
