//
//  AsyncAwaitAPIs.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 22/02/26.
//

import Foundation

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

final class AsyncAwaitAPIs {
    static let shared = AsyncAwaitAPIs()
    private init() {}
    
    func fetshPosts() async throws -> [Post] {
        let (data, _) = try await URLSession.shared.data(from: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
        let posts = try JSONDecoder().decode([Post].self, from: data)
        return posts
    }
}
