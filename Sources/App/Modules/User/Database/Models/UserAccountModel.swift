//
//  UserAccountModel.swift
//  
//
//  Created by Mico Miloloza on 28.06.2023..
//

import Vapor
import Fluent


final class UserAccountModel: DatabaseModelInterface {
    typealias Module = UserModule
    
    @ID()
    var id: UUID?
    @Field(key: FieldKeys.v1.username)
    var username: String
    @Field(key: FieldKeys.v1.email)
    var email: String
    @Field(key: FieldKeys.v1.password)
    var password: String
    
    init() { }
    
    init(id: UUID? = nil, username: String, email: String, password: String) {
        self.id = id
        self.username = username
        self.email = email
        self.password = password
    }
    
    struct FieldKeys {
        struct v1 {
            static var username: FieldKey { "username" }
            static var email: FieldKey { "email" }
            static var password: FieldKey { "password" }
        }
    }
}
