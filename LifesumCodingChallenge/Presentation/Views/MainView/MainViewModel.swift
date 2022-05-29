//
//  MainViewModel.swift
//  LifesumCodingChallenge
//
//  Created by Mateusz Holubowski on 28/05/2022.
//

import Foundation

@MainActor
class MainViewModel: ObservableObject {
    private let getRandomFoodItemUseCase: GetRandomFoodItemUseCase

    let title: String = "Shake device to present random food"
    let errorButtonTitle: String = "Ok"
    @Published private(set) var currentFoodItem: FoodItem?
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String = ""
    @Published var presentError: Bool = false

    init(getRandomFoodItemUseCase: GetRandomFoodItemUseCase) {
        self.getRandomFoodItemUseCase = getRandomFoodItemUseCase
    }

    func onShake() async {
        await fetchNewFoodItem()
    }
}

private extension MainViewModel {
    func fetchNewFoodItem() async {
        isLoading = true
        let result = await getRandomFoodItemUseCase.execute()
        isLoading = false
        print("Fetched finished \(result)")
        switch result {
        case let .success(item):
            currentFoodItem = item
        case let .failure(error):
            handleError(error: error)
            return
        }
    }

    func handleError(error: Error) {
        errorMessage = error.localizedDescription
        presentError = true
    }
}
