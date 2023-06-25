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
            
//            static var title: Fiel
//            static var slug: Field
//            static var imageKey: F
//            static var excerpt: Fi
//            static var date: Field
//            static var content: Fi
//            static var categoryId:
            try await database.schema(BlogPostModel.schema)
                .id()
                .field(BlogPostModel.FieldKeys.v1.title, .string, .required)
                .field(BlogPostModel.FieldKeys.v1.slug, .string, .required)
                .field(BlogPostModel.FieldKeys.v1.imageKey, .string, .required)
                .field(BlogPostModel.FieldKeys.v1.excerpt, .string, .required)
                .field(BlogPostModel.FieldKeys.v1.date, .date, .required)
                .field(BlogPostModel.FieldKeys.v1.content, .string, .required)
                .field(BlogPostModel.FieldKeys.v1.categoryId, .uuid)
                .foreignKey(BlogPostModel.FieldKeys.v1.categoryId, references: BlogCategoryModel.schema, .id, onDelete: .setNull, onUpdate: .cascade)
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
                                             imageKey: "/img/posts/\(index)",
                                             excerpt: "Lorem ipsum",
                                             date: Date().addingTimeInterval(-Double.random(in: 0...(86400 * 60))),
                                             content: """
Bees are winged insects closely related to wasps and ants, known for their roles in pollination and, in the case of the best-known bee species, the western honey bee, for producing honey. Bees are a monophyletic lineage within the superfamily Apoidea. They are presently considered a clade, called Anthophila. There are over 16,000 known species of bees in seven recognized biological families.[1][2] Some species – including honey bees, bumblebees, and stingless bees – live socially in colonies while most species (>90%) – including mason bees, carpenter bees, leafcutter bees, and sweat bees – are solitary.
                                             
Bees are found on every continent except Antarctica, in every habitat on the planet that contains insect-pollinated flowering plants. The most common bees in the Northern Hemisphere are the Halictidae, or sweat bees, but they are small and often mistaken for wasps or flies. Bees range in size from tiny stingless bee species, whose workers are less than 2 millimetres (0.08 in) long,[3] to Megachile pluto, the largest species of leafcutter bee, whose females can attain a length of 39 millimetres (1.54 in).
""",
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
