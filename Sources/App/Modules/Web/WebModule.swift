//
//  WebModule.swift
//  
//
//  Created by Mico Miloloza on 25.06.2023..
//

import Vapor


struct WebModule: ModuleInterface {
    let router = WebRouter()
    
    func boot(_ app: Application) throws {
        try router.boot(routes: app.routes)
    }
}
