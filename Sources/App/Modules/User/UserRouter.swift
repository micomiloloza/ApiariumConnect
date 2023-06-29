//
//  UserRouter.swift
//  
//
//  Created by Mico Miloloza on 28.06.2023..
//

import Vapor


struct UserRouter: RouteCollection {
    let controller = UserFrontendController()
    
    func boot(routes: RoutesBuilder) throws {
        routes.on(.GET, "sign-in", use: controller.signInView)
        routes.on(.POST, "sign-in", use: controller.signInAction)
    }
}
