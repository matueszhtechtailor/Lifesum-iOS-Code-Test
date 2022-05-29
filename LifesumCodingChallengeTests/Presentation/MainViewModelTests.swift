//
//  MainViewModelTests.swift
//  LifesumCodingChallengeTests
//
//  Created by Mateusz Holubowski on 29/05/2022.
//

import Foundation
@testable import LifesumCodingChallenge
import XCTest

@MainActor
class MainViewModelTests: XCTestCase {
    func testMainViewModel() async {
        let foodItem = FoodItem(meta: Meta(code: 12), response: Response(carbs: 12, fiber: 12, title: "title", pcstext: "qwd", potassium: 32, sodium: 32, calories: 32, fat: 43, sugar: 32, gramsperserving: 32, cholesterol: 12, protein: 43, unsaturatedfat: 12, saturatedfat: 32))
        let mockedError: Error = URLError(.cannotLoadFromNetwork)

        let useCaseMock = GetRandomFoodItemUseCaseMock()
        let viewModel = MainViewModel(getRandomFoodItemUseCase: useCaseMock)

        XCTAssertEqual(viewModel.title, "Shake device to present random food")
        XCTAssertEqual(viewModel.currentFoodItem, nil)
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.errorMessage, "")
        XCTAssertEqual(viewModel.presentError, false)

        //test success
        useCaseMock.result = .success(foodItem)
        await viewModel.onShake()
        XCTAssertEqual(viewModel.currentFoodItem, foodItem)
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.errorMessage, "")
        XCTAssertEqual(viewModel.presentError, false)

        //test failure
        useCaseMock.result = .failure(mockedError)
        await viewModel.onShake()
        XCTAssertEqual(viewModel.currentFoodItem, foodItem)
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.errorMessage, mockedError.localizedDescription)
        XCTAssertEqual(viewModel.presentError, true)
    }
}

private class GetRandomFoodItemUseCaseMock: GetRandomFoodItemUseCase {
    var result: Result<FoodItem, Error>? = nil

    func execute() async -> Result<FoodItem, Error> {
        await withCheckedContinuation { continuation in
            guard let result = result else {
                assertionFailure()
                return
            }
            continuation.resume(returning: result)
        }
    }
}
