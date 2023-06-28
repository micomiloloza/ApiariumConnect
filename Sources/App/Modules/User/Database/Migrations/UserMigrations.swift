//
//  UserMigrations.swift
//  
//
//  Created by Mico Miloloza on 28.06.2023..
//

import Vapor
import Fluent


enum UserMigrations {
    struct v1: AsyncMigration {
        func prepare(on database: Database) async throws {
            try await database.schema(UserAccountModel.schema)
                .id()
                .field(UserAccountModel.FieldKeys.v1.username, .string, .required)
                .field(UserAccountModel.FieldKeys.v1.email, .string, .required)
                .field(UserAccountModel.FieldKeys.v1.password, .string, .required)
                .unique(on: UserAccountModel.FieldKeys.v1.email)
                .create()
        }
        
        func revert(on database: Database) async throws {
            try await database.schema(UserAccountModel.schema).delete()
        }
    }
    
    struct seed: AsyncMigration {
        func prepare(on database: Database) async throws {
            let password = "ChangeMe1"
            let userAccountModel = UserAccountModel(username: "admin", email: "root@localhost.localhost", password: try Bcrypt.hash(password))
            
            try await userAccountModel.create(on: database)
        }
        
        func revert(on database: Database) async throws {
            
        }
    }
}
