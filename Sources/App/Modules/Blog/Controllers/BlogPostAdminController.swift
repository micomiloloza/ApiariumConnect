//
//  BlogPostAdminController.swift
//  
//
//  Created by Mico Miloloza on 23.09.2023..
//

import Vapor
import Fluent


struct BlogPostAdminController {
    private func find(_ req: Request) async throws -> BlogPostModel {
        guard let modelId = req.parameters.get("postId"),
              let uuid = UUID(uuidString: modelId),
              let post = try await BlogPostModel
            .query(on: req.db)
            .filter(\.$id == uuid)
            .with(\.$category)
            .first()
        else {
            throw Abort(.notFound)
        }
        
        return post
    }
    
    func listView(_ req: Request) async throws -> Response {
        let api = BlogPostApiController()
        let models = try await BlogPostModel.query(on: req.db).with(\.$category).all()
        let posts = models.map { api.mapList($0) }
        
        let template = BlogPostAdminListTemplate(.init(title: "Blog Posts", list: posts))
        
        return req.templates.renderHtml(template)
    }
    
    func detailView(_ req: Request) async throws -> Response {
        let api = BlogPostApiController()
        let model = try await find(req)
        let detail = api.mapDetail(model)
        
        let template = BlogPostAdminDetailTemplate(.init(title: detail.title, detail: detail))
        
        return req.templates.renderHtml(template)
    }
}
