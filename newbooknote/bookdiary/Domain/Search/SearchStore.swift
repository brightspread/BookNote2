//
//  SearchStore.swift
//  bookdiary
//
//  Created by Leo on 1/28/24.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct SearchStore {

    @ObservableState
    struct State: Equatable {
        var searchQuery = ""
        var results: [Book] = []
    }

    enum Action {
        case searchQueryChanged(String)
        case searchQueryChangeDebounced
        case searchResponse(Result<[Book], Error>)
        case searchResultTapped(Book)
    }

    @Dependency(\.bookClient) var bookClient
    private enum CancelID { case book }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
                case let .searchQueryChanged(query):
                    state.searchQuery = query
                    guard state.searchQuery.isEmpty.not else {
                        state.results = []
                        return .cancel(id: CancelID.book) //TODO: Test
                    }
                    return .none
                
                case .searchQueryChangeDebounced:
                    guard state.searchQuery.isEmpty.not else {
                        return .none
                    }
                    return .run { [query = state.searchQuery] send in
                        await send(.searchResponse(Result {
                            try await self.bookClient.search(query: query)
                        }))
                    }
                    .cancellable(id: CancelID.book)
                case .searchResponse(.failure):
                    state.results = []
                    //TODO:
                    return .none
                case let .searchResponse(.success(response)):
                    state.results = response
                    return .none
                case let .searchResultTapped(book):
                    return .none
            }
        }
    }

}
