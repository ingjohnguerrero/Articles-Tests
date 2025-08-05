//
//  APIArticlesService.swift
//  Sparq
//
//  Created by John Guerrero on 8/5/25.
//
import Foundation

actor APIArticlesService: ArticlesService {

    var cacheStore: SwiftDataArticlesService
    private let apiURL = URL(string: "https://raw.githubusercontent.com/lanestp/challenge-for-ios/refs/heads/main/test.json")!

    init() {
        self.cacheStore = try! SwiftDataArticlesService()
    }

    func fetchArticles() async throws -> [Article] {
        let articles = (try? await fetchFromAPI()) ?? []
        try await saveToStore(articles: articles)
        return try await cacheStore.fetchArticles()
    }

    func fetchFromAPI() async throws -> [Article] {
        let data = try Data(contentsOf: apiURL)
        let decoder = JSONDecoder()
        let articleDTOs = try decoder.decode([ArticleDTO].self, from: data)
        let articles = articleDTOs.map { articleDTO in
            articleDTO.map()
        }
        return articles
    }

    func saveToStore(articles: [Article]) async throws {
        guard !articles.isEmpty else { return }
        try await cacheStore.deleteAllArticles()
        for article in articles {
            try await cacheStore.save(article: article)
        }
    }
}
