//
//  Launch.swift
//  JibSpaceX
//
//  Created by Ibrahim Beltagy on 14/02/2021.
//  Copyright © 2021 Ibrahim Beltagy. All rights reserved.
//

import Foundation
import ObjectMapper

class Launch: Mappable {
    
    var id: String = ""
    var launchNumber: Int = 0
    var details: String = ""
    var date: Date?
    var upcoming = false
    var successful = false
    var rocketID = ""

    // MARK: - Mapping -
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        launchNumber <- map["flight_number"]
        details <- map["details"]
        date <- (map["date_unix"], DateTransform())
        upcoming <- map["upcoming"]
        successful <- map["success"]
        rocketID <- map["rocket"]
    }
    
}
