//
//  SearchTextField.swift
//  bookdiary
//
//  Created by Leo on 1/29/24.
//

import SwiftUI
import ComposableArchitecture

struct SearchTextField: View {
    @Bindable var store: StoreOf<SearchStore>

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")

            TextField("Text", text: $store.searchQuery.sending(\.searchQueryChanged)
            )
            .textFieldStyle(.roundedBorder)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
        }
        .task(id: store.searchQuery) {
            do {
                try await Task.sleep(for: .milliseconds(300))
                await store.send(.searchQueryChangeDebounced).finish()
            } catch {}
        }
    }
}
