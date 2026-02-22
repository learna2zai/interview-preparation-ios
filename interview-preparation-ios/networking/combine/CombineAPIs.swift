//
//  CombineAPIs.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 22/02/26.
//

import Foundation
import Combine

class CombineAPIs {
    
    let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
    
    func getUsers() -> AnyPublisher<[User], Error> {
        let dataPublisher = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
        return dataPublisher
            .decode(type: [User].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
