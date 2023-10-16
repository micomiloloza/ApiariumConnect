//
//  BlogPostAdminController.swift
//  
//
//  Created by Mico Miloloza on 23.09.2023..
//

import Vapor
import Fluent


struct BlogPostAdminController: AdminListController {
    var modelName: Name = .init(singular: "post")
    
    var parameterId: String = "postId"
    
    typealias DatabaseModel = BlogPostModel
    
    
    func listColumns() -> [ColumnContext] {
        [
            .init(key: "image"),
            .init(key: "title")
        ]
    }
    
    func listCells(for model: BlogPostModel) -> [CellContext] {
        [
            .init(value: model.imageKey, type: .image),
            .init(value: model.title, link: .init(label: model.title))
        ]
    }
    
    // MARK: - Helper functions
    private func renderEditForm(_ req: Request, _ title: String, _ form: BlogPostEditForm) -> Response {
        let template = BlogPostAdminEditTemplate(
            .init(
                title: title,
                form: form.render(req: req)
            )
        )
        
        return req.templates.renderHtml(template)
    }
    
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
//    
//    // MARK: - List
//    func listView(_ req: Request) async throws -> Response {
//        let api = BlogPostApiController()
//        let models = try await BlogPostModel.query(on: req.db).with(\.$category).all()
//        let posts = models.map { api.mapList($0) }
//        
//        let template = BlogPostAdminListTemplate(.init(title: "Blog Posts", list: posts))
//        
//        return req.templates.renderHtml(template)
//    }
    
    // MARK: - Details
    func detailView(_ req: Request) async throws -> Response {
        let api = BlogPostApiController()
        let model = try await find(req)
        let detail = api.mapDetail(model)
        
        let template = BlogPostAdminDetailTemplate(.init(title: detail.title, detail: detail))
        
        return req.templates.renderHtml(template)
    }
    
    // MARK: - Create
    /// Inside the controller, we should be able to use the form to create a new blog post.
    /// Inside this method, we initialize an empty model and a form using that model.
    /// We just call the load function so the form can load the category relations and that's it: we're ready to render.
    func createView(_ req: Request) async throws -> Response {
        let model = BlogPostModel()
        let form = BlogPostEditForm(model)
        try await form.load(req: req)
        
        return renderEditForm(req, "Create post", form)
    }
    
    func createAction(_ req: Request) async throws -> Response {
        let model = BlogPostModel()
        let form = BlogPostEditForm(model)
        
        try await form.load(req: req)
        try await form.process(req: req)
        let isValid = try await form.validate(req: req)
        
        guard isValid else {
            return renderEditForm(req, "Create post", form)
        }
        
        try await form.write(req: req)
        try await model.create(on: req.db)
        try await form.save(req: req)
        
        return req.redirect(to: "/admin/blog/posts/\(model.id!.uuidString)/")
    }
    
    // MARK: - Update
    func updateView(_ req: Request) async throws -> Response {
        let model = try await find(req)
        let form = BlogPostEditForm(model)
        
        try await form.load(req: req)
        try await form.read(req: req)
        
        return renderEditForm(req, "Update post", form)
    }
    
    func updateAction(_ req: Request) async throws -> Response {
        let model = try await find(req)
        let form = BlogPostEditForm(model)
        
        try await form.load(req: req)
        try await form.process(req: req)
        
        let isValid = try await form.validate(req: req)
        
        guard isValid else {
            return renderEditForm(req, "Update post", form)
        }
        
        try await form.write(req: req)
        try await model.update(on: req.db)
        try await form.save(req: req)
        
        return req.redirect(to: "/admin/blog/posts/\(model.id!.uuidString)/update/")
    }
    
    // MARK: - Delete
    func deleteView(_ req: Request) async throws -> Response {
        let model = try await find(req)
        
        let template = BlogPostAdminDeleteTemplate(context:
                .init(
                    title: "Delete post",
                      name: model.title,
                      type: "post"
                )
        )
        
        return req.templates.renderHtml(template)
    }
    
    func deleteAction(_ req: Request) async throws -> Response {
        let model = try await find(req)
        
        try await req.fs.delete(key: model.imageKey)
        try await model.delete(on: req.db)
        
        return req.redirect(to: "/admin/blog/posts/")
    }
}
