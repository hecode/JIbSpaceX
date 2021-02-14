//
//  HomeItemDetailsViewModel.swift
//  JibSpaceX
//
//  Created by Ibrahim Beltagy on 14/02/2021.
//  Copyright © 2021 Ibrahim Beltagy. All rights reserved.
//

import Foundation
import ImageSlideshow

class HomeItemDetailsViewModel: AbstractViewModel {
    var homeItemDetailsService: HomeItemDetailsService = HomeItemDetailsService()
    
    var rocketID: String = ""
    var rocket: Rocket? {
        didSet {
            if let imageURLs = self.rocket?.imagesURLs {
                for item in imageURLs {
                    if let sdWebImageSource = SDWebImageSource(urlString: item, placeholder: UIImage(named: Constants.Placeholders.listingItemPlaceholderImage.rawValue)) {
                        media.append(sdWebImageSource)
                    }
                }
            }
            
        }
    }
    
    var media: [InputSource] = []

}

// MARK: - Network -
// reachability should be checked for as well
extension HomeItemDetailsViewModel {
    
    func loadRocket(id: String) {
        // fetching animation
        delegate?.updateUI(data: nil, status: .fetching, actionSource: nil)
        
        // Adding caching would be helpful
        // networking should be separate as a service and other services that need can use it and it would have the general error handling and messages, and auth/refresh token where applicable, etc.
        
        homeItemDetailsService.getHomeItemDetails(id: id, completion: { (rocketResults, error) in
            guard let rocket = rocketResults, error == nil else {
                self.delegate?.updateUI(data: nil, status: .error(message: error?.localizedDescription ?? Constants.genericAPIErrorMessage), actionSource: nil)
                return
            }
            
            self.rocket = rocket
            
            self.delegate?.updateUI(data: nil, status: .success, actionSource: nil)
        })
        
    }
    
}
