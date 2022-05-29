//
//  AppConfigurator.swift
//  LifesumCodingChallenge
//
//  Created by Mateusz Holubowski on 28/05/2022.
//

import Foundation
import UIKit
import SwiftUI

@MainActor class AppConfiguration {
    let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }

    func initializeRootView() {
        let viewModel = initializeMainViewModel()
        window?.rootViewController = UIHostingController(rootView: MainView(viewModel: viewModel))
    }

    private func initializeMainViewModel() -> MainViewModel {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 2
        let urlSession = URLSession(configuration: configuration)
        let requestable = HttpClient(session: urlSession)
        let requestFactory = RequestFactoryImpl(
            scheme: "https://",
            host: "api.lifesum.com",
            authorization: "23863708:465c0554fd00da006338c72e282e939fe6576a25fd00c776c0fbe898c47c9876")
        let foodRepository = FoodRepositoryImpl(requestable: requestable, requestFactory: requestFactory)
        let useCase = GetRandomFoodItemUseCaseImpl(foodRepository: foodRepository)
        return MainViewModel(getRandomFoodItemUseCase: useCase)
    }
}
