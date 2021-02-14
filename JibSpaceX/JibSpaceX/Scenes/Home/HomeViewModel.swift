//
//  HomeViewModel.swift
//  JibSpaceX
//
//  Created by Ibrahim Beltagy on 14/02/2021.
//  Copyright © 2021 Ibrahim Beltagy. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class HomeViewModel {
    var homeService: HomeServiceProtocol = HomeService()
    
    var launches = BehaviorSubject<[Launch]>(value: [])
}

// MARK: - Network -
// reachability should be checked for as well
extension HomeViewModel {
    
    func resetAndLoadHomeItems() {
        // if this was cached/saved locally we could load it here while making the new request
        launches.onNext([])
        loadHomeItems()
    }
    
    func loadHomeItems() {
        // Adding caching would be helpful
        // networking should be separate as a service and other services that need can use it and it would have the general error handling and messages, and auth/refresh token where applicable, etc.
        
        homeService.getHomeItems { (launchesResult, error) in
            guard let launches = launchesResult, error == nil else {
                self.launches.onError(error ?? Errors.apiError())
                return
            }
            
            self.launches.onNext(launches)
        }
        
    }
    
}
