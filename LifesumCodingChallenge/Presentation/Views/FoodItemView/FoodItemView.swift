//
//  FoodItemView.swift
//  LifesumCodingChallenge
//
//  Created by Mateusz Holubowski on 28/05/2022.
//

import SwiftUI

struct FoodItemView: View {
    @ObservedObject var viewModel: FoodItemViewModel

    init(viewModel: FoodItemViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            FoodCircleView(viewModel: viewModel)
            FoodTableView(viewModel: viewModel)
            Spacer()
        }
    }
}

struct FoodItemView_Previews: PreviewProvider {
    static var previews: some View {
        let response = Response(
            carbs: 20,
            fiber: 20,
            title: "Chicken drumstick, with skin",
            pcstext: "",
            potassium: 12,
            sodium: 13,
            calories: 200,
            fat: 231,
            sugar: 321,
            gramsperserving: 232,
            cholesterol: 123,
            protein: 32,
            unsaturatedfat: 43,
            saturatedfat: 12
        )
        let viewModel = FoodItemViewModel(
            foodItem: FoodItem(
                meta: nil,
                response: response
            )
        )
        FoodItemView(viewModel: viewModel)
    }
}
