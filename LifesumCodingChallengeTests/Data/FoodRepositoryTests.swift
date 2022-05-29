//
//  FoodRepositoryTests.swift
//  LifesumCodingChallengeTests
//
//  Created by Mateusz Holubowski on 29/05/2022.
//

import Foundation
@testable import LifesumCodingChallenge
import XCTest

class FoodRepositoryTests: XCTestCase {
    func testFoodItemRequestSuccess() async throws {
        let mockRequest: URLRequest? = URLRequest(url: URL(string: "anyrequest")!)
        let mockResult = mockJson.data(using: .utf8)!
        let mockResultFood = try JSONDecoder().decode(FoodItem.self, from: mockResult)

        let requestable = RequestableMock(result: mockResult, error: nil)
        let factory = RequestFactoryMock(request: mockRequest)
        let foodRepository = FoodRepositoryImpl(requestable: requestable, requestFactory: factory)

        let id = 12
        let result = await foodRepository.getFoodItem(id: id)

        XCTAssertEqual(factory.id, id)
        XCTAssertEqual(requestable.request, mockRequest)
        XCTAssertEqual(try result.get(), mockResultFood)
    }

    func testFoodItemRequestError() async throws {
        let mockRequest: URLRequest? = URLRequest(url: URL(string: "anyrequest")!)
        let mockError: Error = URLError(.badServerResponse)

        let requestable = RequestableMock(result: nil, error: mockError)
        let factory = RequestFactoryMock(request: mockRequest)
        let foodRepository = FoodRepositoryImpl(requestable: requestable, requestFactory: factory)

        let id = 12
        let result = await foodRepository.getFoodItem(id: id)

        XCTAssertEqual(factory.id, id)
        XCTAssertEqual(requestable.request, mockRequest)

        switch result {
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, mockError.localizedDescription)
        default:
            XCTAssert(true, "Result should be failure")
        }
    }
}

private class RequestableMock: Requestable {
    var request: URLRequest?
    private let result: Data?
    private let error: Error?

    init(result: Data?, error: Error?) {
        self.result = result
        self.error = error
    }

    func fetch(_ request: URLRequest) async throws -> Data {
        self.request = request
        if let error = error {
            throw error
        }
        return result!
    }
}

private class RequestFactoryMock: RequestFactory {
    private let request: URLRequest?
    var id: Int?

    init(request: URLRequest?) {
        self.request = request
    }

    func foodItemRequest(id: Int) -> URLRequest? {
        self.id = id
        return request
    }
}

extension FoodItem: Equatable {
    public static func == (lhs: FoodItem, rhs: FoodItem) -> Bool {
        lhs.response?.title == rhs.response?.title &&
        lhs.meta?.code == rhs.meta?.code
    }
}

private extension FoodRepositoryTests {
    var mockJson: String {
        """
            {
            "meta": {
            "code": 200
                },
            "response": {
            "carbs": 3.04,
            "fiber": 0.0,
            "title": "Ricotta cheese",
            "pcstext": "Whole cheese",
            "potassium": 0.105,
            "sodium": 0.084,
            "calories": 174,
            "fat": 12.98,
            "sugar": 0.27,
            "gramsperserving": 20.0,
            "cholesterol": 0.051,
            "protein": 11.26,
            "unsaturatedfat": 4.012,
            "saturatedfat": 8.295
                }
            }
        """
    }
}
