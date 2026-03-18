//
//  UserRepositoryImpl.swift
//  interview-preparation-ios
//
//  Created on 23/02/26.
//

import Foundation

struct UserListRequest: APIRequest {
    var method: HTTPMethod
    var headers: [String : String]
    var body: Data?
    var queryItems: [URLQueryItem]?
    var path: String { "/users/all" }
    
    init(method: HTTPMethod = .GET,
         headers: [String : String] = [:],
         body: Data? = nil,
         queryItems: [URLQueryItem]? = nil) {
        self.method = method
        self.headers = headers
        self.body = body
        self.queryItems = queryItems
    }
}

struct UserRepositoryImpl: UserRepository {

    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func getUsers() async throws -> [User] {
        let users: [UserResponseModel] = try await apiClient.send(UserListRequest())
        return users.compactMap { $0.toDTO() }.map { $0.toDomainModel() }
    }
    
    func createUser(user: User) async throws -> Bool {
        return true
    }
    
    func updateUser(userId: Int, user: User) async throws -> Bool {
        true
    }
    
    func deleteUser(userId: Int) async throws -> Bool {
        true
    }
    
    func deleteAllUsers() async throws -> Bool {
        true
    }
    
    func getUser(userId: Int) async throws -> User {
        .init(id: 2, name: "User Name", email: "abc@gmail.com")
    }
}
