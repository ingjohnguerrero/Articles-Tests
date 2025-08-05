//
//  MockArticlesServiceTests.swift
//  Sparq
//
//  Created by John Guerrero on 8/5/25.
//

import XCTest
@testable import Sparq

@MainActor
final class MockArticlesServiceTests: XCTestCase {
    private var sut: MockArticlesService!

    override func setUp() {
        sut = MockArticlesService()
    }
    func testInitIsNotNil() {
        XCTAssertNotNil(sut)
    }

    func testFetchArticlesReturnsMockData() async throws {
        let articles = try await sut.fetchArticles()
        XCTAssertEqual(articles.count, 5)
    }
}
