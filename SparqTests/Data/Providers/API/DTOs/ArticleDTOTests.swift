//
//  ArticleDTOTests.swift
//  Sparq
//
//  Created by John Guerrero on 8/5/25.
//

import XCTest
@testable import Sparq

final class ArticleDTOTests: XCTestCase {

    private var sut: ArticleDTO!

    private let responseString = """
        [
            { "title": "Innovative AI Grant Proposal", "description": "A proposal focused on securing funding for an artificial intelligence research initiative." },
            { "title": "Early-Stage Startup Grant Application", "description": "A guide to applying for grants tailored for new technology startups." },
            { "title": "Green Energy Research Grant", "description": "A structured grant proposal for renewable energy innovations." },
            { "title": "Healthcare Tech Funding Request", "description": "A funding request for developing new healthcare technology solutions." },
            { "title": "STEM Education Grant Proposal", "description": "A proposal aimed at securing funds for STEM education programs." }
        ]
        """

    func testInit() {
        sut = ArticleDTO(
            title: "Title",
            description: "Description"
        )
        XCTAssertNotNil(sut)
    }

    func testMapping() {
        let jsonData = responseString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let articles: [ArticleDTO] = try! decoder.decode([ArticleDTO].self, from: jsonData)
        XCTAssertEqual(articles.count, 5)
    }
}
