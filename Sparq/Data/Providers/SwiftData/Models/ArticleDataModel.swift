//
//  ArticleDataModel.swift
//  Sparq
//
//  Created by John Guerrero on 8/5/25.
//

import SwiftData

@Model
final class ArticleDataModel {
    public var title: String
    public var content: String

    init(title: String, content: String) {
        self.title = title
        self.content = content
    }
}

extension ArticleDataModel: ArticleMapper {
    func map() -> Article {
        Article(title: self.title, description: self.content)
    }
}
