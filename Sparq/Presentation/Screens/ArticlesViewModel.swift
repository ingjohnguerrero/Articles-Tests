//
//  ArticlesViewModel.swift
//  Sparq
//
//  Created by John Guerrero on 8/5/25.
//

import Foundation

enum ArticlesViewModelState: Equatable {
    case loading
    case loaded([Article])
    case error(ArticlesViewModelError)

    static func == (lhs: ArticlesViewModelState, rhs: ArticlesViewModelState) -> Bool {
        switch (lhs, rhs) {
            case (.loading, .loading):
                return true
            case (.loaded(let lhsArticles), .loaded(let rhsArticles)):
                return lhsArticles.count == rhsArticles.count
            case (.error(let lhsError), .error(let rhsError)):
                return lhsError.localizedDescription == rhsError.localizedDescription
            default:
                return false
        }
    }
}

enum ArticlesViewModelError: Error, LocalizedError {
    case serviceError(Error)

    var errorDescription: String? {
        switch self {
            case .serviceError(let error):
                return error.localizedDescription
        }
    }
}

@Observable
class ArticlesViewModel {
    var state: ArticlesViewModelState = .loading
    @ObservationIgnored var service: ArticlesService

    init(service: ArticlesService = MockArticlesService()) {
        self.service = service
    }

    func onStart() async {
        state = .loading
        do {
            let articles = try await service.fetchArticles()
            state = .loaded(articles)
        } catch {
            state = .error(.serviceError(error))
        }
    }
}
