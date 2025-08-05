//
//  ArticlesService.swift
//  Sparq
//
//  Created by John Guerrero on 8/5/25.
//

protocol ArticlesService {
    func fetchArticles() async throws -> [Article]
}
