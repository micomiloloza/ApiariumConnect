//
//  WebRouter.swift
//  
//
//  Created by Mico Miloloza on 03.06.2023..
//

import Vapor


struct WebRouter: RouteCollection {
    
    let frontendController = WebFrontendController()
    
    func boot(routes: RoutesBuilder) throws {
        routes.on(.GET, use: frontendController.homeView)
    }
}
