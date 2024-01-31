//
//  bookdiaryApp.swift
//  bookdiary
//
//  Created by Leo on 1/27/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct bookdiaryApp: App {
    var body: some Scene {
        WindowGroup {
            SearchView(store: Store(
                initialState: SearchStore.State()){
                    SearchStore()
                        ._printChanges()
                }
            )
        }
    }
}
