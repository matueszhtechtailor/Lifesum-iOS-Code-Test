//
//  MainView.swift
//  LifesumCodingChallenge
//
//  Created by Mateusz Holubowski on 28/05/2022.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            ZStack {
                if let foodItem = viewModel.currentFoodItem {
                    VStack {
                        FoodItemView(viewModel: FoodItemViewModel(foodItem: foodItem))
                    }
                } else {
                    VStack {
                        Text(viewModel.title)
                            .foregroundColor(.black)
                            .padding()
                    }
                }
                if viewModel.isLoading {
                    ProgressView()
                }
            }
        }.onShake {
            Task {
                await viewModel.onShake()
            }
        }.alert(viewModel.errorMessage, isPresented: $viewModel.presentError) {
            Button(viewModel.errorButtonTitle, role: .cancel) { }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = MainViewModel(getRandomFoodItemUseCase: GetRandomFoodItemUseCaseForPreview())
        MainView(viewModel: viewModel)
    }

    private class GetRandomFoodItemUseCaseForPreview: GetRandomFoodItemUseCase {
        func execute() async -> Result<FoodItem, Error> {
            let foodItem = FoodItem(
                meta: nil,
                response: nil
            )
            return .success(foodItem)
        }
    }
}

