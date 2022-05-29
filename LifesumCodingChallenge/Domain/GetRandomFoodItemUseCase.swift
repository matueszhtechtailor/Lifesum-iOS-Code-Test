//
//  GetRandomFoodItemUseCase.swift
//  LifesumCodingChallenge
//
//  Created by Mateusz Holubowski on 28/05/2022.
//

import Foundation

public protocol GetRandomFoodItemUseCase {
    func execute() async -> Result<FoodItem, Error>
}

class GetRandomFoodItemUseCaseImpl: GetRandomFoodItemUseCase {
    private let foodRepository: FoodRepository
    private let randomFunc: ((Range<Int>) -> Int)

    public init(
        foodRepository: FoodRepository,
        randomFunc: @escaping ((Range<Int>) -> Int) = Int.random
    ) {
        self.foodRepository = foodRepository
        self.randomFunc = randomFunc
    }

    func execute() async -> Result<FoodItem, Error> {
        let id = randomFunc(Constants.idRange)
        let result = await foodRepository.getFoodItem(id: id)
        return result
    }
}

private extension GetRandomFoodItemUseCaseImpl {
    enum Constants {
        static let idRange: Range<Int> = 1..<200
    }
}
