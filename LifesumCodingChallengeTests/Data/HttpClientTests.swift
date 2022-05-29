//
//  HttpClientTests.swift
//  LifesumCodingChallengeTests
//
//  Created by Mateusz Holubowski on 29/05/2022.
//

import Foundation
import XCTest
import LifesumCodingChallenge

class HttpClientTests: XCTestCase {
    func testSuccess() async throws {
        let httpClient = makeHttpClient()
        HttpClientInterceptor.result = .success("Success".data(using: .utf8)!)
        let request = URLRequest(url: URL(string: "https://some.request.com/path")!)
        let result = try await httpClient.fetch(request)

        XCTAssertEqual(request, HttpClientInterceptor.request)
        XCTAssertEqual(result, try HttpClientInterceptor.result.get())
    }

    func testError() async throws {
        let httpClient = makeHttpClient()
        let mockError: Error = URLError(.badServerResponse)
        HttpClientInterceptor.result = .failure(mockError)
        let request = URLRequest(url: URL(string: "https://some.request.com/path")!)

        do {
            _ = try await httpClient.fetch(request)
            XCTAssert(true, "Call should throw error")
        } catch {
            XCTAssertEqual(error.localizedDescription, mockError.localizedDescription)
        }
    }
}

private extension HttpClientTests {
    func makeHttpClient() -> HttpClient {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [HttpClientInterceptor.self]
        return HttpClient(session: URLSession(configuration: configuration))
    }
}

private class HttpClientInterceptor: URLProtocol {
    static var result: Result<Data, Error> = .success("Success".data(using: .utf8)!)

    static var request: URLRequest?

    override class func canInit(with request: URLRequest) -> Bool {
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        Self.request = request
        switch Self.result {
        case .success(let data):
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        case .failure(let error):
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() {
    }
}
