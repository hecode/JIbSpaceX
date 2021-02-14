//
//  ListingItemCellProtocol.swift
//  JibSpaceX
//
//  Created by Ibrahim Beltagy on 14/02/2021.
//  Copyright © 2021 Ibrahim Beltagy. All rights reserved.
//

import Foundation

// makes it easier to reuse the cell with different models.

protocol ListingItemCellProtocol {
    var name: String { get }
    var launchNumber: Int { get }
    var details: String { get }
    var date: Date? { get }
    var upcoming: Bool? { get }
}
