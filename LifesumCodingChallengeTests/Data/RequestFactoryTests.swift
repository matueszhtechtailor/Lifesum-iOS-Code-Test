//
//  RequestFactoryTests.swift
//  LifesumCodingChallengeTests
//
//  Created by Mateusz Holubowski on 29/05/2022.
//

import Foundation
@testable import LifesumCodingChallenge
import XCTest

class RequestFactoryTests: XCTestCase {
    func testFoodItemRequest() {
        let scheme = "scheme"
        let host = "host"
        let authorization = "authorization"
        let requestFactory = RequestFactoryImpl(scheme: scheme, host: host, authorization: authorization)

        let id = 99
        let request = requestFactory.foodItemRequest(id: id)

        XCTAssertEqual(request?.httpMethod, "GET")
        XCTAssertEqual(request?.url?.absoluteString, "schemehost/v2/foodipedia/codetest?foodid=\(id)")
        XCTAssertEqual(request?.allHTTPHeaderFields, ["Authorization": "authorization"])
    }
}
