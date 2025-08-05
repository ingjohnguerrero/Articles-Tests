//
//  Article.swift
//  Sparq
//
//  Created by John Guerrero on 8/5/25.
//

struct Article {
    var title: String
    var description: String
}

extension Article: Identifiable {
    var id: String { title }
}
