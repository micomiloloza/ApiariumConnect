//
//  BlogRouter.swift
//  
//
//  Created by Mico Miloloza on 13.06.2023..
//

import Vapor


struct BlogRouter: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let controller = BlogFrontendController()
        
        routes.on(.GET, "blog", use: controller.blogView)
        routes.on(.GET, .anything, use: controller.postView)
    }
}
