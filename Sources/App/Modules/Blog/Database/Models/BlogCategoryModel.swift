//
//  BlogCategoryModel.swift
//  
//
//  Created by Mico Miloloza on 25.06.2023..
//

import Fluent
import Vapor


final class BlogCategoryModel: Model {
    static let schema = "blog_categories"
    
    @ID() var id: UUID?
    @Field(key: FieldKeys.v1.title) var title: String
    @Children(for: \.$category) var posts: [BlogPostModel]
    
    public init() { }
    
    public init(id: UUID? = nil, title: String) {
        self.id = id
        self.title = title
    }
    
    struct FieldKeys {
        struct v1 {
            static var title: FieldKey { "title" }
        }
    }
}
