//
//  SwiftDataArticlesService.swift
//  Sparq
//
//  Created by John Guerrero on 8/5/25.
//

import Foundation
import SwiftData

actor SwiftDataArticlesService {
    private let container: ModelContainer
    private let context: ModelContext

    init(inMemory: Bool = false) throws {
        let schema = Schema([ArticleDataModel.self])
        let config = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: inMemory
        )
        container = try ModelContainer(for: schema, configurations: [config])
        context = ModelContext(container)
    }

    func save(article: Article) throws {
        let item = ArticleDataModel(
            title: article.title,
            content: article.description
        )
        context.insert(item)
        try context.save()
    }

    func fetchDataArticles() throws -> [ArticleDataModel] {
        let descriptor = FetchDescriptor<ArticleDataModel>(
            sortBy: [SortDescriptor(\ArticleDataModel.title, order: .reverse)]
        )
        return try context.fetch(descriptor)
    }

    func deleteAllArticles() throws {
        let items = try context.fetch(FetchDescriptor<ArticleDataModel>())
        for item in items {
            context.delete(item)
        }
        try context.save()
    }
}

extension SwiftDataArticlesService: ArticlesService {
    func fetchArticles() async throws -> [Article] {
        try fetchDataArticles().map { dataModel in
            dataModel.map()
        }
    }
}
