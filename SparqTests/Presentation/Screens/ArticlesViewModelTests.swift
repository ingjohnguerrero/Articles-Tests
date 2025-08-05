//
//  ArticlesViewModelTests.swift
//  Sparq
//
//  Created by John Guerrero on 8/5/25.
//

import XCTest
@testable import Sparq

@MainActor
final class ArticlesViewModelTests: XCTestCase {
    private var sut: ArticlesViewModel!

    override func setUpWithError() throws {
        sut = .init(service: MockArticlesService())
    }
    
    func testInitResultIsNotNil() throws {
        XCTAssertNotNil(sut)
    }

    func testInitialStateIsLoading() throws {
        XCTAssertEqual(sut.state, .loading)
    }

    func testServiceIsNotNil() throws {
        XCTAssertNotNil(sut.service)
    }

    func testOnStartFetchArticlesSuccessfully() async throws {
        await sut.onStart()
        if case .loaded(let articles) = sut.state {
            XCTAssertTrue(articles.count > 0)
        } else {
            XCTFail("Articles should not be empty")
        }
    }

    func testOnStartFetchArticlesWitError() async throws {
        sut = .init(service: MockArticlesService(shouldReturnError: true))
        await sut.onStart()
        if case .error(let error) = sut.state {
            let errorMessage = try XCTUnwrap(error.errorDescription)
            XCTAssertFalse(errorMessage.isEmpty)
        } else {
            XCTFail("Articles should be empty")
        }
    }
}
