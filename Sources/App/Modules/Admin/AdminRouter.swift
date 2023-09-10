//
//  AdminRouter.swift
//  
//
//  Created by Mico Miloloza on 10.09.2023..
//

import Vapor


struct AdminRouter: RouteCollection {
    
    let controller = AdminFrontendController()
    
    func boot(routes: RoutesBuilder) throws {
        routes
            .grouped(AuthenticatedUser.redirectMiddleware(path: "/sign-in/"))
            .on(.GET, "admin", use: controller.dashboardView)
    }
}
