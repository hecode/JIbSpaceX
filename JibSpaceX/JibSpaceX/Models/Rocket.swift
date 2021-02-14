//
//  Rocket.swift
//  JibSpaceX
//
//  Created by Ibrahim Beltagy on 14/02/2021.
//  Copyright © 2021 Ibrahim Beltagy. All rights reserved.
//

import Foundation
import ObjectMapper

class Rocket: Mappable {
    
    var id: String = ""
    var name: String = ""
    var imagesURLs: [String] = []
    var description: String = ""
    var wikipediaURL: String = ""
    
    // MARK: - Mapping -
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        imagesURLs <- map["flickr_images"]
        description <- map["description"]
        wikipediaURL <- map["wikipedia"]
    }
    
}
