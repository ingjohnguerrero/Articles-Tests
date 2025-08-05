//
//  ArticlesView.swift
//  Sparq
//
//  Created by John Guerrero on 8/5/25.
//

import SwiftUI

struct ArticlesView: View {
    @State var viewModel: ArticlesViewModel = .init()
    var body: some View {
        NavigationStack {
            makeBody()
                .navigationTitle("Articles")
                .task {
                    await viewModel.onStart()
                }
                .navigationDestination(for: Article.self) { article in
                    ArticleDetailsView(article: article)
                }
        }
    }

    @ViewBuilder func makeBody() -> some View {
        Group {
            switch viewModel.state {
                case .loading:
                    Text("Loading...")
                case .loaded(let articles):
                    makeListView(with: articles)
                case .error(let error):
                    Text("Error: \(error)")
            }
        }
    }

    @ViewBuilder func makeListView(with articles: [Article]) -> some View {
        if articles.isEmpty {
            ScrollView {
                Text("No articles found.")
            }.refreshable {
                await viewModel.onStart()
            }
        } else {
            List(articles) { article in
                NavigationLink(value: article) {
                    Text(article.title)
                }
            }
            .refreshable {
                await viewModel.onStart()
            }
        }
    }
}

#Preview {
    ArticlesView(viewModel: ArticlesViewModel(service: MockArticlesService()))
}
