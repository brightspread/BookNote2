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
                SearchTextField(store: store)
                SearchItemList(store: store)
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
