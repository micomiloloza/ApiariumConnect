//
//  BlogFrontendController.swift
//  
//
//  Created by Mico Miloloza on 13.06.2023..
//

import Vapor
import Fluent


struct BlogFrontendController {
    func blogView(_ req: Request) async throws -> Response {
        let api = BlogPostApiController()
        
        let postModels = try await BlogPostModel
            .query(on: req.db)
            .sort(\.$date, .descending)
            .all()
        
        let posts = postModels.map { api.mapList($0) }
        
        let context = BlogPostsContext(icon: "📰", title: "Blog",
                                       message: "News and stories about the world of bees and their keepers",
                                       posts: posts)
        
        return req.templates.renderHtml(
            BlogPostsTemplate(context)
        )
    }
    
    func postView(_ req: Request) async throws -> Response {
        let slug = req.url.path.trimmingCharacters(in: .init(charactersIn: "/"))
        
        guard let postModel = try await BlogPostModel
            .query(on: req.db)
            .filter(\.$slug == slug)
            .with(\.$category)
            .first() else {
            return req.redirect(to: "/")
        }
        
        let api = BlogPostApiController()
        let post = api.mapDetail(postModel)
        
        let context = BlogPostContext(post: post)
        
        return req.templates.renderHtml(BlogPostTemplate(context))
    }
}
