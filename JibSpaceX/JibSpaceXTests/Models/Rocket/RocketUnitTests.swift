//
//  RocketUnitTests.swift
//  JibSpaceXTests
//
//  Created by Ibrahim Beltagy on 14/02/2021.
//  Copyright © 2021 Ibrahim Beltagy. All rights reserved.
//

import XCTest
@testable import JibSpaceX

class RocketUnitTests: XCTestCase {
    
    func testSuccessRocketInit() {
        guard let path = Bundle(for: RocketUnitTests.self).path(forResource: "RocketsJSONs", ofType: "plist"),
            let nsDictionary = NSDictionary(contentsOfFile: path)  else {
                XCTFail()
                return
        }
        
        guard let validJSONString = nsDictionary["validJSON"] as? String,
            let data = validJSONString.data(using: .utf8),
            let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: AnyObject]
            else {
                XCTFail()
                return
        }
        
        let rocket = Rocket.init(JSON: json)
        XCTAssert(rocket?.name == "Falcon Heavy")
        XCTAssert(rocket?.description == """
            With the ability to lift into orbit over 54 metric tons (119,000 lb)--a mass equivalent to a 737 jetliner loaded with passengers, crew, luggage and fuel--Falcon Heavy can lift more than twice the payload of the next closest operational vehicle, the Delta IV Heavy, at one-third the cost.
            """) // could be loaded as external string instead with the full string
        XCTAssert(rocket?.id == "5e9d0d95eda69974db09d1ed")
        XCTAssert(rocket?.wikipediaURL == "https://en.wikipedia.org/wiki/Falcon_Heavy")
        XCTAssert(rocket?.imagesURLs.count == 4)
    }
    
    func testFailedRocketInit() {
        guard let path = Bundle(for: RocketUnitTests.self).path(forResource: "RocketsJSONs", ofType: "plist"),
            let nsDictionary = NSDictionary(contentsOfFile: path)  else {
                XCTFail()
                return
        }
        
        guard let validJSONString = nsDictionary["emptyJSON"] as? String,
            let data = validJSONString.data(using: .utf8),
            let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: AnyObject]
            else {
                XCTFail()
                return
        }
        
        let rocket = Rocket.init(JSON: json)
        XCTAssert(rocket?.name.isEmpty ?? true)
        XCTAssert(rocket?.description.isEmpty ?? true) // could be loaded as external string instead with the full string
        XCTAssert(rocket?.id.isEmpty ?? true)
        XCTAssert(rocket?.wikipediaURL.isEmpty ?? true)
        XCTAssert(rocket?.imagesURLs.count == 0)
    }
    
}
