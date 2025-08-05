//
//  MockArticlesService.swift
//  Sparq
//
//  Created by John Guerrero on 8/5/25.
//

import Foundation

actor MockArticlesService: ArticlesService {

    private let shouldReturnError: Bool
    private let responseString = """
        [
            { "title": "Innovative AI Grant Proposal", "description": "A proposal focused on securing funding for an artificial intelligence research initiative." },
            { "title": "Early-Stage Startup Grant Application", "description": "A guide to applying for grants tailored for new technology startups." },
            { "title": "Green Energy Research Grant", "description": "A structured grant proposal for renewable energy innovations." },
            { "title": "Healthcare Tech Funding Request", "description": "A funding request for developing new healthcare technology solutions." },
            { "title": "STEM Education Grant Proposal", "description": "A proposal aimed at securing funds for STEM education programs." }
        ]
        """

    init(shouldReturnError: Bool = false) {
        self.shouldReturnError = shouldReturnError
    }

    func fetchArticles() async throws -> [Article] {
        if shouldReturnError {
            throw URLError(.badServerResponse)
        }
        let jsonData = responseString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let articleDTOs: [ArticleDTO] = try! decoder.decode([ArticleDTO].self, from: jsonData)
        let articles = articleDTOs.map { dto in
            dto.map()
        }
        return articles
    }
}
