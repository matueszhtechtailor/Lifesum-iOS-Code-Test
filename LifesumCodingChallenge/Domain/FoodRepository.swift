//
//  FoodRepository.swift
//  LifesumCodingChallenge
//
//  Created by Mateusz Holubowski on 28/05/2022.
//

import Foundation

public protocol FoodRepository {
    func getFoodItem(id: Int) async -> Result<FoodItem, Error>
}
