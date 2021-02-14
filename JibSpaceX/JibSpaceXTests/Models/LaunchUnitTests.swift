//
//  LaunchUnitTests.swift
//  JibSpaceXTests
//
//  Created by Ibrahim Beltagy on 14/02/2021.
//  Copyright © 2021 Ibrahim Beltagy. All rights reserved.
//

import XCTest
@testable import JibSpaceX

class LaunchUnitTests: XCTestCase {
    
    func testSuccessLaunchInit() {
        
        guard let path = Bundle(for: LaunchUnitTests.self).path(forResource: "LaunchesJSONs", ofType: "plist"),
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
        
        let launch = Launch.init(JSON: json)
        XCTAssert(launch?.name == "CRS-20")
        XCTAssert(launch?.date == Date(timeIntervalSince1970: 1583556631))
        XCTAssert(launch?.details == """
            SpaceX\'s 20th and final Crew Resupply Mission under the original NASA CRS contract, this mission brings essential supplies to the International Space Station using SpaceX\'s reusable Dragon spacecraft. It is the last scheduled flight of a Dragon 1 capsule. (CRS-21 and up under the new Commercial Resupply Services 2 contract will use Dragon 2.) The external payload for this mission is the Bartolomeo ISS external payload hosting platform. Falcon 9 and Dragon will launch from SLC-40, Cape Canaveral Air Force Station and the booster will land at LZ-1. The mission will be complete with return and recovery of the Dragon capsule and down cargo.
            """) // could be loaded as external string instead with the full string
        XCTAssert(launch?.id == "5eb87d42ffd86e000604b384")
        XCTAssert(launch?.launchNumber == 91)
        XCTAssert(launch?.rocketID == "5e9d0d95eda69973a809d1ec")
        XCTAssert(launch?.successful == true)
        XCTAssert(launch?.upcoming == false)
    }
    
    func testFailedLaunchInit() {
        
        guard let path = Bundle(for: LaunchUnitTests.self).path(forResource: "LaunchesJSONs", ofType: "plist"),
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
        
        let launch = Launch.init(JSON: json)
        XCTAssert(launch?.name.isEmpty ?? true)
        XCTAssertNil(launch?.date)
        XCTAssert(launch?.details.isEmpty ?? true)
        XCTAssert(launch?.id.isEmpty ?? true)
        XCTAssert(launch?.launchNumber == 0)
        XCTAssert(launch?.rocketID.isEmpty ?? true)
        XCTAssert(launch?.successful == false)
        XCTAssert(launch?.upcoming == false)
    }
    
}
