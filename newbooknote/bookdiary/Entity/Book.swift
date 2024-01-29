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
