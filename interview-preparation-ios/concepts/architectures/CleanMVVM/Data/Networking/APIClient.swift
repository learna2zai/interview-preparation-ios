//
//  APIClient.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 23/02/26.
//

import Foundation

protocol APIClientProtocol {
    func login(email: String, passowrd: String) async throws -> Bool
    func register(name: String, email: String, password: String) async throws -> Bool
    func fetchProfile() async throws -> UserDTO
    func logout() async throws -> Bool
}

final class APIClient: APIClientProtocol {
    
    var userDTO: UserDTO?
    
    private let baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func login(email: String, passowrd: String) async throws -> Bool {
        // store token details after login
        
        let (data, _) = try await URLSession.shared.data(
            from: URL(string: "https://jsonplaceholder.typicode.com/users")!,
            delegate:  SSLCertificatePinning() //SSLPublicKeyPinning()
        )
        
        let users = try JSONDecoder().decode([UserDTO].self, from: data)
        
        print(users)
        
        return true
    }
    
    func register(name: String, email: String, password: String) async throws -> Bool {
        self.userDTO = UserDTO(id: 1, name: name, email: email)
        return true
    }
    
    func fetchProfile() async throws -> UserDTO {
        return self.userDTO!
    }
    
    func logout() async throws -> Bool {
        return false
    }
}
