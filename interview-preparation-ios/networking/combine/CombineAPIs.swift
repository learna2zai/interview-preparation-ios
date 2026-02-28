//
//  CombineAPIs.swift
//  interview-preparation-ios
//
//  Created on 22/02/26.
//

import Foundation
import Combine

struct CombineUser: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let website: String
}

class CombineAPIs {
    
    let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
    
    func getUsers() -> AnyPublisher<[CombineUser], Error> {
        let dataPublisher = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
        return dataPublisher
            .decode(type: [CombineUser].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
