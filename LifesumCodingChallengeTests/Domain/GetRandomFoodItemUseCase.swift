//
//  GetRandomFoodItemUseCase.swift
//  LifesumCodingChallengeTests
//
//  Created by Mateusz Holubowski on 29/05/2022.
//

import Foundation
@testable import LifesumCodingChallenge
import XCTest

class GetRandomFoodItemUseCaseTests: XCTestCase {
    func testFoodItemRequestSuccess() async throws {
        let foodItemResult = FoodItem(meta: Meta(code: 12), response: Response(carbs: 12, fiber: 12, title: "title", pcstext: "qwd", potassium: 32, sodium: 32, calories: 32, fat: 23, sugar: 32, gramsperserving: 32, cholesterol: 12, protein: 43, unsaturatedfat: 12, saturatedfat: 32))

        let mockFoodRepository = FoodRepositoryMock(result: .success(foodItemResult))
        let mockId = 99
        var range: Range<Int>?
        let mockRandomFunc: (Range<Int>) -> Int = {
            range = $0
            return mockId
        }
        let getRandomFoodItemUseCase = GetRandomFoodItemUseCaseImpl(
            foodRepository: mockFoodRepository,
            randomFunc: mockRandomFunc
        )

        let result = await getRandomFoodItemUseCase.execute()

        XCTAssertEqual(mockFoodRepository.id, mockId)
        XCTAssertEqual(range, 1..<200)
        XCTAssertEqual(try result.get(), foodItemResult)
    }

    func testFoodItemRequestError() async throws {
        let mockError: Error = URLError(.badServerResponse)
        let mockFoodRepository = FoodRepositoryMock(result: .failure(mockError))
        let getRandomFoodItemUseCase = GetRandomFoodItemUseCaseImpl(foodRepository: mockFoodRepository)

        let result = await getRandomFoodItemUseCase.execute()

        XCTAssertTrue((1..<200).contains(mockFoodRepository.id!))
        switch result {
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, mockError.localizedDescription)
        default:
            XCTAssert(true, "Result should be failure")
        }
    }
}

private class FoodRepositoryMock: FoodRepository {
    private let result: Result<FoodItem, Error>
    var id: Int?

    init(result: Result<FoodItem, Error>) {
        self.result = result
    }

    func getFoodItem(id: Int) async -> Result<FoodItem, Error> {
        self.id = id
        return result
    }
}
