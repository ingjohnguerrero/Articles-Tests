//
//  ArticleDetailsView.swift
//  Sparq
//
//  Created by John Guerrero on 8/5/25.
//

import SwiftUI

struct ArticleDetailsView: View {
    var article: Article
    var body: some View {
        VStack {
            Text(article.title)
                .font(.largeTitle)
            Text(article.description)
                .font(.body)
                .lineLimit(nil)
            Spacer()
        }
        .padding(.top)
        .padding(.bottom)
        .padding(.horizontal, 10)
    }
}

#Preview {
    ArticleDetailsView(
        article: Article(
            title: "Innovative AI Grant Proposal",
            description: "A proposal focused on securing funding for an artificial intelligence research initiative."
        )
    )
}
