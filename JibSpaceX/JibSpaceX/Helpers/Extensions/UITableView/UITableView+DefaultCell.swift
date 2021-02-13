//
//  UITableView+DefaultCell.swift
//  JibSpaceX
//
//  Created by Ibrahim Beltagy on 14/02/2021.
//  Copyright © 2021 Ibrahim Beltagy. All rights reserved.
//

import UIKit

extension UITableView {
    
    func defaultCell() -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        
        return cell
    }

}
