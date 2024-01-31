//
//  BookClient.swift
//  bookdiary
//
//  Created by Leo on 1/28/24.
//

// 테이블뷰에 List뷰가 서브뷰로 있음
// Cell 형태의 뷰가 따로 있음
// parent view에서 API 호출함 -> List안에 Cell로 데이터를 넘겨줘야함.

import Foundation
import ComposableArchitecture
import Alamofire

@DependencyClient
struct BookClient {
    var search: @Sendable (_ query: String) async throws -> [Book]
}

extension BookClient: DependencyKey {
    static let NAVER_SEARCH_URL = "https://openapi.naver.com/v1/search/book.json"
    static let NAVER_HEADERS = HTTPHeaders([
        "X-Naver-Client-Id": Bundle.main.object(forInfoDictionaryKey: "NAVER_CLIENT_ID") as! String,
        "X-Naver-Client-Secret": Bundle.main.object(forInfoDictionaryKey: "NAVER_CLIENT_SECRET") as! String
    ])

    static let liveValue = BookClient(
        search: { query in
             let response = await AF.request(NAVER_SEARCH_URL + "?q=\(query)&maxResults=40",
                       encoding: JSONEncoding.default,
                       headers: NAVER_HEADERS)
                .responseDecodable(decoder: <#T##DataDecoder#>, completionHandler: <#T##(DataResponse<Decodable, AFError>) -> Void#>)


            var components = URLComponents(string: "https://openapi.naver.com/v1/search/book.json")!
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
