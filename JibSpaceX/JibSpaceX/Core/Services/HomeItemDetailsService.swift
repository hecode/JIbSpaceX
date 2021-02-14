//
//  HomeItemDetailsService.swift
//  JibSpaceX
//
//  Created by Ibrahim Beltagy on 14/02/2021.
//  Copyright © 2021 Ibrahim Beltagy. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

protocol HomeItemDetailsServiceProtocol {
    
    // MARK: - Home page items -
    func getHomeItemDetails(id: String, completion: @escaping (Rocket?, Error?) -> Void)
    
}

class HomeItemDetailsService: HomeItemDetailsServiceProtocol {
    
    func getHomeItemDetails(id: String, completion: @escaping (Rocket?, Error?) -> Void) {
        // check for internet connection / load cache before request
        
        guard let url = URL(string: Constants.baseUrl + Endpoint.homeItemDetailsEndpoints.homeItemDetailsEndpoint) else {
            return
        }
        
        AF.request(url, method: HTTPMethod.get, parameters: ["id": id], encoding: URLEncoding.default, headers: ["Content-Type": "application/json"]).responseJSON{ response in
            
            switch response.result {
            case .success(let value):
                guard let value = value as? [String: Any] else {
                    completion(nil, response.error)
                    return
                }
                
                let rocket = Mapper<Rocket>().map(JSON: value)
               
                completion(rocket, nil)
                
            case .failure:
                completion(nil, response.error)
            }
        }
    }
    
}
