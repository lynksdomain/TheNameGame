//
//  ProfileApiTests.swift
//  TheNameGameTests
//
//  Created by Lynk on 3/24/21.
//

import XCTest
@testable import TheNameGame

var profileApi: ProfileApi!

class ProfileApiTests: XCTestCase {

    override class func setUp() {
        super.setUp()
        profileApi = ProfileApi()
    }
    
    override class func tearDown() {
        profileApi = nil
        super.tearDown()
    }
    
    func testReceivingProfiles() {
        let promise = expectation(description: "Expected Profiles")
        var profiles: [Profile]?
        
        profileApi.getProfiles { (result) in
            switch result {
            case let .success(allProfiles):
                profiles = allProfiles
                promise.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 5)
        XCTAssertNotNil(profiles)
    }
}
