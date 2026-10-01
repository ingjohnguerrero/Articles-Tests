//
//  Article.swift
//  Sparq
//
//  Created by John Guerrero on 8/5/25.
//

struct Article: Identifiable {
    var id: Int
    var title: String
    var description: String
}

extension Article: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Article, rhs: Article) -> Bool {
        lhs.id == rhs.id
    }
}
