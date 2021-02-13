//
//  HomeService.swift
//  JibSpaceX
//
//  Created by Ibrahim Beltagy on 14/02/2021.
//  Copyright © 2021 Ibrahim Beltagy. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

protocol HomeServiceProtocol {
    
    // MARK: - Home page items -
    func getHomeItems(completion: @escaping ([Launch]?, Error?) -> Void)
    
}

class HomeService: HomeServiceProtocol {
    
    func getHomeItems(completion: @escaping ([Launch]?, Error?) -> Void) {
        // check for internet connection / load cache before request
        
        guard let url = URL(string: Constants.baseUrl + Endpoint.homeEndpoints.homeItemsEndpoint) else {
            return
        }
        
        //  The provided api doesn’t specify what parameter to use for the pagination but it should be implemented if available, and it's advised to have pagination in cases of lots of entries (would need filtering as well in that case since not all the data would be available for local filtering)
        AF.request(url, method: HTTPMethod.get, parameters: [:], encoding: URLEncoding.default, headers: ["Content-Type": "application/json"]).responseJSON{ response in
            
            switch response.result {
            case .success(let value):
                guard let value = value as? [[String: Any]] else {
                    completion(nil, response.error)
                    return
                }
                
                let launches = Mapper<Launch>().mapArray(JSONArray: value)
                completion(launches, nil)
                
            case .failure:
                completion(nil, response.error)
            }
        }
    }
    
}
