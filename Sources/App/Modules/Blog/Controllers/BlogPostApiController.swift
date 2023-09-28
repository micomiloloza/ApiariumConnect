//
//  BlogPostApiController.swift
//  
//
//  Created by Mico Miloloza on 23.09.2023..
//

import Vapor


struct BlogPostApiController {
    func mapList(_ model: BlogPostModel) -> Blog.Post.List {
        return .init(id: model.id!,
                     title: model.title,
                     slug: model.slug,
                     image: model.imageKey,
                     excerpt: model.excerpt,
                     date: model.date)
    }
    
    func mapDetail(_ model: BlogPostModel) -> Blog.Post.Detail {
        return .init(id: model.id!,
                     title: model.title,
                     slug: model.slug,
                     image: model.imageKey,
                     excerpt: model.excerpt,
                     date: model.date,
                     category: .init(id: model.category.id!,
                                     title: model.category.title),
                     content: model.content)
    }
}
