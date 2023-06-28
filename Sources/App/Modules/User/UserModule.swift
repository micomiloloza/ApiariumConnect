//
//  UserModule.swift
//  
//
//  Created by Mico Miloloza on 28.06.2023..
//

import Vapor


struct UserModule: ModuleInterface {
    let router = UserRouter()
    
    func boot(_ app: Application) throws {
        app.migrations.add(UserMigrations.v1())
        app.migrations.add(UserMigrations.seed())
        
        try router.boot(routes: app.routes)
    }
}