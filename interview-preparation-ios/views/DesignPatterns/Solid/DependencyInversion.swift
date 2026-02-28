//
//  DependencyInversion.swift
//  interview-preparation-ios
//
//  Created on 01/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation

struct DependencyInversion: SolidPrincipleProtocol {
    let title: String = "Dependency Inversion"
    let description: String = "Dependancy Inversion is a software design principle that states that high-level modules should not depend on low-level modules. Both should depend on abstractions."
    
    let problem: String = """
        // MARK: - Dependency Inversion

        class User {
            var name: String
            
            init(name: String) {
                self.name = name
            }
        }

        class MYSQLDatabase {
            func save(user: User) -> Bool {
                print("Saving user to MYSQL Database")
                return true
            }
        }

        class UserService {
            private let database: MYSQLDatabase
            
            init(database: MYSQLDatabase) {
                self.database = database
            }
            
            func saveUser(user: User) -> Bool {
                return database.save(user: user)
            }
        }

        let usrService = UserService(database:  MYSQLDatabase())

        /// voilets the DIP
        """
    
    let resolution: String = """
        protocol Database {
            func save(user: User) -> Bool
        }

        class MYSQLDB: Database {
            func save(user: User) -> Bool {
                return true
            }
        }

        class RefactoredUserService {
            private let database: Database
            
            init(database: Database) {
                self.database = database
            }
            
            func save(user: User) -> Bool {
                database.save(user: user)
            }
        }

        class PostgreSQL: Database {
            func save(user: User) -> Bool {
                return true
            }
        }

        let isUserSaved = RefactoredUserService(database: PostgreSQL())
                                    .save(user: .init(name: "App User"))

        """
}
