//
//  SearchItemCell.swift
//  bookdiary
//
//  Created by Leo on 1/29/24.
//

import SwiftUI
import ComposableArchitecture

struct SearchItemCell: View {
    let book: Book

    var body: some View {
        HStack {
            Image(systemName: "􀉛")
            Text(book.title)
        }
    }
}

#Preview {
    let book = Book(id: 0, title: "책 이름")
    return SearchItemCell(book: book)
}

