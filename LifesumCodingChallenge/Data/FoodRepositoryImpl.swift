//
//  FoodRepositoryImpl.swift
//  LifesumCodingChallenge
//
//  Created by Mateusz Holubowski on 28/05/2022.
//

import Foundation

public class FoodRepositoryImpl: FoodRepository {
    private let requestable: Requestable
    private let requestFactory: RequestFactory

    public init(requestable: Requestable, requestFactory: RequestFactory) {
        self.requestable = requestable
        self.requestFactory = requestFactory
    }

    public func getFoodItem(id: Int) async -> Result<FoodItem, Error> {
        guard let request = requestFactory.foodItemRequest(id: id) else {
            return .failure(NSError(domain: "Request factory error", code: 1))
        }
        do {
            let response = try await requestable.fetch(request)
            let foodItem = try JSONDecoder().decode(FoodItem.self, from: response)
            return .success(foodItem)
        } catch {
            return .failure(error)
        }
    }
}
