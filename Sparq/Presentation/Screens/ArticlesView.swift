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
        makeBody()
            .task {
                await viewModel.onStart()
            }
    }

    @ViewBuilder func makeBody() -> some View {
        Group {
            switch viewModel.state {
                case .loading:
                    Text("Loading...")
                case .loaded(let articles):
                    List(articles) { article in
                        Text(article.title)
                    }
                case .error(let error):
                    Text("Error: \(error)")
            }
        }
    }
}

#Preview {
    ArticlesView(viewModel: ArticlesViewModel(service: MockArticlesService()))
}
