//
//  APIArticlesService.swift
//  Sparq
//
//  Created by John Guerrero on 8/5/25.
//
import Foundation

actor APIArticlesService: ArticlesService {
    func fetchArticles() async throws -> [Article] {
        let url = URL(string: "https://raw.githubusercontent.com/lanestp/challenge-for-ios/refs/heads/main/test.json")!
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let articleDTOs = try decoder.decode([ArticleDTO].self, from: data)
        let articles = articleDTOs.map { articleDTO in
            articleDTO.map()
        }
        return articles
    }
}
