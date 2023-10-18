//
//  BlogRouter.swift
//  
//
//  Created by Mico Miloloza on 13.06.2023..
//

import Vapor


struct BlogRouter: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        // MARK: - Controllers
        let controller = BlogFrontendController()
        let postAdminController = BlogPostAdminController()
        let categoryAdminController = BlogCategoryAdminController()
        
        // MARK: - Routes
        routes.on(.GET, "blog", use: controller.blogView)
        routes.on(.GET, .anything, use: controller.postView)
        
        let blog = routes.grouped(AuthenticatedUser.redirectMiddleware(path: "/"))
            .grouped("admin", "blog")
        
        // MARK: - Categories routes
        let categories = blog.grouped("categories")
        categories.on(.GET, use: categoryAdminController.listView)
        
        let categoryId = categories.grouped(":categoryId")
        categoryId.on(.GET, use: categoryAdminController.detailView)
        
        // MARK: - Posts routes
        let posts = blog.grouped("posts")
        posts.on(.GET, use: postAdminController.listView)
        posts.on(.GET, "create", use: postAdminController.createView)
        posts.on(.POST, "create", use: postAdminController.createAction)
        
        // MARK: - PostId routes
        let postId = posts.grouped(":postId")
        postId.on(.GET, use: postAdminController.detailView)
        postId.on(.GET, "update", use: postAdminController.updateView)
        postId.on(.POST, "update", use: postAdminController.updateAction)
        postId.on(.GET, "delete", use: postAdminController.deleteView)
        postId.on(.POST, "delete", use: postAdminController.deleteAction)
    }
}
