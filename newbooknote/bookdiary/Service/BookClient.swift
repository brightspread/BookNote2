//
//  BookClient.swift
//  bookdiary
//
//  Created by Leo on 1/28/24.
//

import Foundation
import ComposableArchitecture

@DependencyClient
struct BookClient {
    var search: @Sendable (_ query: String) async throws -> [Book]
}

extension BookClient: DependencyKey {
    static let liveValue = BookClient(
        search: { query in
            var components = URLComponents(string: "TODO: API URL String")!
            components.queryItems = [URLQueryItem(name: "TODO: queryName", value: query)]

            let (data, _) = try await URLSession.shared.data(from: components.url!)
            return try JSONDecoder().decode([Book].self, from: data)
        }
    )
}

extension DependencyValues {
    var bookClient: BookClient {
        get { self[BookClient.self] }
        set { self[BookClient.self] = newValue }
    }
}
