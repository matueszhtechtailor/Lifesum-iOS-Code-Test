//
//  FoodItemViewModel.swift
//  LifesumCodingChallenge
//
//  Created by Mateusz Holubowski on 28/05/2022.
//

import Foundation

@MainActor
class FoodItemViewModel: ObservableObject {
    private let foodItem: FoodItem

    init(foodItem: FoodItem) {
        self.foodItem = foodItem
    }
}

extension FoodItemViewModel {
    var title: String {
        "\(foodItem.response?.title ?? "No title")"
    }

    var nutrients: [FoodItemViewModel.Nutrient] {
        [
            Nutrient(name: "Carbs", value: foodItem.response?.carbs),
            Nutrient(name: "Protein", value: foodItem.response?.protein),
            Nutrient(name: "Fat", value: foodItem.response?.fat)
        ]
            .compactMap { $0 }
    }

    var caloriesValue: String {
        guard let calories = foodItem.response?.calories else {
            return "-"
        }
        return "\(Int(calories))"
    }

    var caloriesDescription: String {
        guard foodItem.response?.calories != nil else {
            return ""
        }
        return "Calories per serving"
    }
}

extension FoodItemViewModel {
    struct Nutrient {
        let name: String
        let value: Double

        init?(name: String, value: Double?) {
            guard let value = value else { return nil }
            self.name = name
            self.value = value
        }
    }
}

extension FoodItemViewModel.Nutrient: Identifiable {
    var id: String {
        name
    }

    var displayName: String {
        name.uppercased()
    }

    var displayValue: String {
        "\(value)%"
    }
}
