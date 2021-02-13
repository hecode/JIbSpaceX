//
//  DateHelpers.swift
//  JibSpaceX
//
//  Created by Ibrahim Beltagy on 14/02/2021.
//  Copyright © 2021 Ibrahim Beltagy. All rights reserved.
//

import Foundation

func yearsBetweenDates(startDate: Date?, endDate: Date?) -> Int {
    guard let startDate = startDate, let endDate = endDate else {
        return 0
    }
    
    let calendar = NSCalendar.current
    let difference = calendar.dateComponents([.nanosecond], from: startDate, to: endDate)

    return difference.year ?? 0
}
