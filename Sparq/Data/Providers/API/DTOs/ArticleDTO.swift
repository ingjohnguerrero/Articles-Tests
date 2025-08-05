//
//  ArticleDTO.swift
//  Sparq
//
//  Created by John Guerrero on 8/5/25.
//
import Foundation

struct ArticleDTO: Decodable {
    var title: String
    var description: String
}

extension ArticleDTO: ArticleMapper {
    func map() -> Article {
        Article(title: self.title, description: self.description)
    }
}
