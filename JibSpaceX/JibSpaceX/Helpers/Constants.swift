//
//  Constants.swift
//  JibSpaceX
//
//  Created by Ibrahim Beltagy on 14/02/2021.
//  Copyright © 2021 Ibrahim Beltagy. All rights reserved.
//

import UIKit

struct Constants {
    
    static var lang = "en"
    
    static let baseUrl = "https://api.spacexdata.com/"
    
    // MARK: - Invalid Formats -
    // should be localized in an actual app
    static let genericAPIErrorMessage = "something went wrong"
    
    // MARK: - Storyboards -
    
    struct Storyboards {
        
        static let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        enum MainStoryboardIDs: String {
            case HomeViewController = "HomeViewController"
            case HomeItemDetailsViewController = "HomeItemDetailsViewController"
        }
        
    }
    
    // MARK: - Colors -
    // Should be separated to assets in an actual application with SwiftGen for example
    
    struct Colors {
        static let grayColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
    }
    
    // MARK: - Placeholders -

    enum Placeholders: String {
        case listingItemPlaceholderImage = "listing_item_placeholder_image"
    }
    
}
