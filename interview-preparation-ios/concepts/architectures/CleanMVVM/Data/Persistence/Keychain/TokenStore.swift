//
//  TokenStore.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 25/02/26.
//

import Foundation
import Security

enum TokenStoreError: Error {
    case noDataFound
    case unhandledError(String)
}

protocol TokenStoring {
    func save(accessToken: String, refreshToken: String) async throws
    func getAccessToken() async throws -> String?
    func getRefreshToken() async throws -> String?
    func clearTokens() async throws
}

final actor TokenStore: TokenStoring {
    
    private let bundleIdentifire: String = (Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String) ?? "com.companyname.interview-preparation-ios"
    
    private lazy var service = "\(bundleIdentifire)-token-storage"
    
    private enum Keys: String {
        case accessToken = "accessToken"
        case refreshToken = "refreshToken"
    }
    
    // MARK: - Methods for external communications
    
    func save(accessToken: String, refreshToken: String) async throws {
        try insert(key: .accessToken, value: accessToken)
        try insert(key: .refreshToken, value: refreshToken)
    }
    
    func getAccessToken() async throws -> String? {
        try read(key: .accessToken)
    }
    
    func getRefreshToken() async throws -> String? {
        try read(key: .refreshToken)
    }
    
    func clearTokens() async throws {
        try delete(key: .accessToken)
        try delete(key: .refreshToken)
    }
}

// MARK: - Keychain operations

extension TokenStore {
    
    private func insert(key: Keys, value: String) throws {
        let data = Data(value.utf8)
        try delete(key: key)
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
            kSecAttrService as String: service,
            kSecValueData as String: data
        ]
        
        SecItemAdd(query as CFDictionary, nil)
    }
    
    private func read(key: Keys) throws -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
            kSecAttrService as String: service,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess,
              let data = item as? Data,
              let value = String(data: data, encoding: .utf8) else {
            return nil
        }
        
        return value
    }
    
    private func delete(key: Keys) throws {
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
            kSecAttrService as String: service
        ]
        
        SecItemDelete(query as CFDictionary)
    }
}
