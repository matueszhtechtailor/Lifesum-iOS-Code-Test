//
//  FoodItemViewModelTests.swift
//  LifesumCodingChallengeTests
//
//  Created by Mateusz Holubowski on 29/05/2022.
//

import Foundation
@testable import LifesumCodingChallenge
import XCTest

@MainActor
class FoodItemViewModelTests: XCTestCase {
    func testFoodItemViewModel() {
        let carbs = 12.2
        let protein = 32.2
        let fat = 99.0
        let title = "title"
        let calories = 32.2
        let foodItem = FoodItem(meta: Meta(code: 12), response: Response(carbs: carbs, fiber: 12, title: title, pcstext: "qwd", potassium: 32, sodium: 32, calories: calories, fat: fat, sugar: 32, gramsperserving: 32, cholesterol: 12, protein: protein, unsaturatedfat: 12, saturatedfat: 32))

        let viewModel = FoodItemViewModel(foodItem: foodItem)

        XCTAssertEqual(viewModel.title, title)
        XCTAssertEqual(viewModel.caloriesValue, "32")
        XCTAssertEqual(viewModel.caloriesDescription, "Calories per serving")
        XCTAssertEqual(
            viewModel.nutrients,
            [
                FoodItemViewModel.Nutrient(name: "Carbs", value: carbs),
                FoodItemViewModel.Nutrient(name: "Protein", value: protein),
                FoodItemViewModel.Nutrient(name: "Fat", value: fat)
            ]
        )
    }
}

extension FoodItemViewModel.Nutrient: Equatable {
    public static func == (lhs: FoodItemViewModel.Nutrient, rhs: FoodItemViewModel.Nutrient) -> Bool {
        lhs.name == rhs.name && lhs.value == rhs.value
    }
}
