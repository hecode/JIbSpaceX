//
//  DateHelpers.swift
//  JibSpaceX
//
//  Created by Ibrahim Beltagy on 14/02/2021.
//  Copyright © 2021 Ibrahim Beltagy. All rights reserved.
//

import Foundation

enum DateFormat {
    static let yearMonthDayTime = "d MMM yyyy, h:mm a"
}

/// yearsBetweenDates
/// - Parameters:
///   - startDate: start date  for the difference calculation
///   - endDate: end end for the difference calculation
func yearsBetweenDates(startDate: Date?, endDate: Date?) -> Int {
    guard let startDate = startDate, let endDate = endDate else {
        return 0
    }
    
    let calendar = NSCalendar.current
    let difference = calendar.dateComponents([.year], from: startDate, to: endDate)

    return difference.year ?? 0
}

/// getFormattedDate
/// - Parameters:
///   - date: Date?
///   - format: the string format used for the output date string
///   - locale: locale
///   - timeZone: timezone
func getFormattedDate(date: Date?, format: String, locale: Locale? = Locale.current, timeZone: TimeZone? = TimeZone.current) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    dateFormatter.locale = locale
    dateFormatter.timeZone = timeZone
    
    if let date = date {
        return dateFormatter.string(from: date)
    } else {
        return Constants.invalidDateFormat
    }
}
