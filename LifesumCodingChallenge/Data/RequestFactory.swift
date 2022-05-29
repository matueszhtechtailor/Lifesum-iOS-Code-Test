//
//  FoodRepositoryRequestFactory.swift
//  LifesumCodingChallenge
//
//  Created by Mateusz Holubowski on 28/05/2022.
//

import Foundation

public protocol RequestFactory {
    func foodItemRequest(id: Int) -> URLRequest?
}

class RequestFactoryImpl: RequestFactory {
    private let scheme: String
    private let host: String
    private let authorization: String

    public init(scheme: String, host: String, authorization: String) {
        self.scheme = scheme
        self.host = host
        self.authorization = authorization
    }

    func foodItemRequest(id: Int) -> URLRequest? {
        guard let url = URL(string: scheme + host + Request.foodItemRequest(id: id)) else {
            assertionFailure()
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(authorization, forHTTPHeaderField: "Authorization")
        return urlRequest
    }
}

private extension RequestFactoryImpl {
    enum Request {
        static func foodItemRequest(id: Int) -> String {
            return "/v2/foodipedia/codetest?foodid=\(id)"
        }
    }
}
