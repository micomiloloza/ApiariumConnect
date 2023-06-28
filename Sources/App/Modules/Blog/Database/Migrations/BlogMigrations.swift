//
//  BlogMigrations.swift
//  
//
//  Created by Mico Miloloza on 25.06.2023..
//

import Vapor
import Fluent


enum BlogMigrations {
    struct v1: AsyncMigration {
        func prepare(on database: Database) async throws {
            try await database.schema(BlogCategoryModel.schema)
                .id()
                .field(BlogCategoryModel.FieldKeys.v1.title, .string, .required)
                .create()
            
            try await database.schema(BlogPostModel.schema)
                .id()
                .field(BlogPostModel.FieldKeys.v1.title, .string, .required)
                .field(BlogPostModel.FieldKeys.v1.slug, .string, .required)
                .field(BlogPostModel.FieldKeys.v1.imageKey, .string, .required)
                .field(BlogPostModel.FieldKeys.v1.excerpt, .string, .required)
                .field(BlogPostModel.FieldKeys.v1.date, .datetime, .required)
                .field(BlogPostModel.FieldKeys.v1.content, .string, .required)
                .field(BlogPostModel.FieldKeys.v1.categoryId, .uuid)
                .foreignKey(BlogPostModel.FieldKeys.v1.categoryId,
                            references: BlogCategoryModel.schema, .id,
                            onDelete: .setNull,
                            onUpdate: .cascade)
                .unique(on: BlogPostModel.FieldKeys.v1.slug)
                .create()
        }
        
        func revert(on database: Database) async throws {
            try await database.schema(BlogCategoryModel.schema).delete()
            try await database.schema(BlogPostModel.schema).delete()
        }
    }
    
    struct seed: AsyncMigration {
        func prepare(on database: Database) async throws {
            let categories = (1...4).map { index in
                let category = BlogCategoryModel(title: "Sample category - \(index)")
                
                return category
            }
            
            try await categories.create(on: database)
            
            let posts = (1...9).map { index in
                let blogPost = BlogPostModel(title: "Sample post - \(index)",
                                             slug: "sample-post-\(index)",
                                             imageKey: "/img/posts/\(index).jpg",
                                             excerpt: "Lorem ipsum",
                                             date: Date().addingTimeInterval(-Double.random(in: 0...(86400 * 60))),
                                             content: "asdfadsf",
                                             categoryId: categories[Int.random(in: 0..<categories.count)].id!)

                return blogPost
            }
            try await posts.create(on: database)
        }
        
        func revert(on database: Database) async throws {
            try await BlogCategoryModel.query(on: database).delete()
            try await BlogPostModel.query(on: database).delete()
        }
    }
}
