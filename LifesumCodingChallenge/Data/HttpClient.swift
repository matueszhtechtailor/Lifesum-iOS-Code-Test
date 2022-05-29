//
//  HttpClient.swift
//  LifesumCodingChallenge
//
//  Created by Mateusz Holubowski on 28/05/2022.
//

import Foundation

public protocol Requestable {
    func fetch(_ request: URLRequest) async throws -> Data
}

public final class HttpClient: Requestable {
    private let session: URLSession

    public init(session: URLSession) {
        self.session = session
    }

    public func fetch(_ request: URLRequest) async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in
            session
                .dataTask(with: request) { data, response, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                        return
                    }
                    continuation.resume(returning: data ?? Data())
                }
                .resume()
        }
    }
}
