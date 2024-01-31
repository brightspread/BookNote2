//
//  SearchItemList.swift
//  bookdiary
//
//  Created by Leo on 1/29/24.
//

import SwiftUI
import ComposableArchitecture

struct SearchItemList: View {
    @Bindable var store: StoreOf<SearchStore>

    var body: some View {
        List {
            ForEach(store.results) { book in
                VStack(alignment: .leading) {
                    SearchItemCell(book: book)
                }
            }
        }
    }

}


#Preview {
    SearchItemList(store:
                    Store(initialState: SearchStore.State(
                        results: Book.samples
                    ), reducer: {
                        SearchStore()
                            ._printChanges()
                    })
    )
}
