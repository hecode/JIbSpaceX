//
//  UITableView+EmptyMessage.swift
//  JibSpaceX
//
//  Created by Ibrahim Beltagy on 14/02/2021.
//  Copyright © 2021 Ibrahim Beltagy. All rights reserved.
//

import UIKit

extension UITableView {
    
    func setEmptyMessage(_ message: String) {
        DispatchQueue.main.async {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
            messageLabel.text = message
            messageLabel.textColor = Constants.Colors.grayColor
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.sizeToFit()
            
            self.backgroundView = messageLabel
        }
    }
    
    func removeMessage() {
        DispatchQueue.main.async {
            self.backgroundView = nil
        }
    }
    
}
