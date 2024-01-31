//
//  Book.swift
//  bookdiary
//
//  Created by Leo on 1/28/24.
//

import Foundation

struct Book: Decodable, Equatable, Identifiable, Sendable {
    let id: Int
    let title: String
}

extension Book {
    static var samples: [Book] {
        [
            .init(id: 0, title: "첫 번째 책"),
            .init(id: 1, title: "두 번째 책"),
            .init(id: 2, title: "세 번째 책")
        ]
    }
}
