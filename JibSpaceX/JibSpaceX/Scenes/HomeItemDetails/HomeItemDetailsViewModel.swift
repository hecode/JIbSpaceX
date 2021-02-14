//
//  HomeItemDetailsViewModel.swift
//  JibSpaceX
//
//  Created by Ibrahim Beltagy on 14/02/2021.
//  Copyright © 2021 Ibrahim Beltagy. All rights reserved.
//

import Foundation
import ImageSlideshow
import RxSwift

class HomeItemDetailsViewModel {
    var homeItemDetailsService: HomeItemDetailsServiceProtocol = HomeItemDetailsService()
    
    var rocketID: String = ""
    var rocket = BehaviorSubject<Rocket>(value: Rocket())
    
    var media: [InputSource] = []
}

// MARK: - Network -
// reachability should be checked for as well
extension HomeItemDetailsViewModel {
    
    func loadRocket(id: String) {
        // Adding caching would be helpful
        // networking should be separate as a service and other services that need can use it and it would have the general error handling and messages, and auth/refresh token where applicable, etc.
        
        homeItemDetailsService.getHomeItemDetails(id: id, completion: { (rocketResults, error) in
            guard let rocket = rocketResults, error == nil else {
                self.rocket.onError(error ?? Errors.apiError())
                return
            }
            
            let imageURLs = rocket.imagesURLs
            for item in imageURLs {
                if let sdWebImageSource = SDWebImageSource(urlString: item, placeholder: UIImage(named: Constants.Placeholders.listingItemPlaceholderImage.rawValue)) {
                    self.media.append(sdWebImageSource)
                }
            }
            
            self.rocket.onNext(rocket)
        })
        
    }
    
}
