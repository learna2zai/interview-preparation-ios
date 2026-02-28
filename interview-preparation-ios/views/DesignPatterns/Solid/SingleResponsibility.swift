//
//  SingleResponsibility.swift
//  interview-preparation-ios
//
//  Created on 01/03/26.
//  Copyright © 2026 . All rights reserved.
//

import Foundation

struct SingleResponsibility: SolidPrincipleProtocol {
    
    let title = "Single Responsibility Principle"
    let description = "Single responsibility principle states that a class should have only one reason to change. Meaning, a class should have one single responsibility."
    
    let problem = """
            // MARK: -  SRP - Example
            
            class User {
                var name: String
                var email: String
                
                init(name: String, email: String) {
                    self.name = name
                    self.email = email
                }
                
                func saveUserToDatabase() {
                    //
                }
                
                func showWelcomeMessage() {
                    print("Welcome \\(name)!")
                }
            }
            
            /// violate the SRP rule
            """
    
    let resolution = """
            // handle to hold data/model related stuff
            
                class User { 
                    var name: String
                    var email: String
                    
                    init(name: String, email: String) {
                        self.name = name
                        self.email = email
                    }
                }
            
            // handles user saving in to db
            
                class UserRepository { 
                    func saveUserToDatabase(user: User) {
                        // save to db
                    }
                }
            
            // handles user greeting msg
            
                class UserView { 
                    func showWelcomeMessage(name: String) {
                        print("Welcome \\(name)!")
                    }
                }
            """
}
