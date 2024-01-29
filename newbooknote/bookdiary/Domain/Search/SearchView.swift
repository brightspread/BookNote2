//
//  SearchView.swift
//  bookdiary
//
//  Created by Leo on 1/28/24.
//

import SwiftUI
import ComposableArchitecture

struct SearchView: View {
    @Bindable var store: StoreOf<SearchStore>

    var body: some View {
        NavigationStack {

            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")

                    TextField("Text", text: $store.searchQuery.sending(\.searchQueryChanged)
                    )
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                }

                List {
                    ForEach(store.results) { book in
                        VStack(alignment: .leading) {
                            Button {
                                store.send(.searchResultTapped(book))
                            } label: {
                                HStack {
                                    Text(book.title)
                                }
                            }
                        }

                    }
                }
            }
        }
    }
}

#Preview {
    SearchView(
        store: Store(initialState: SearchStore.State()) {
            SearchStore()
                ._printChanges()
        }
    )
}
