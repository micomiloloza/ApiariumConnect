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
        let adminController = BlogPostAdminController()
        
        routes.on(.GET, "blog", use: controller.blogView)
        routes.on(.GET, .anything, use: controller.postView)
        
        let posts = routes.grouped(AuthenticatedUser.redirectMiddleware(path: "/"))
            .grouped("admin", "blog", "posts")
        
        posts.on(.GET, use: adminController.listView)
        
        posts.on(.GET, ":postId", use: adminController.detailView)
    }
}
