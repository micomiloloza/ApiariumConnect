//
//  BlogPostsTemplate.swift
//  
//
//  Created by Mico Miloloza on 13.06.2023..
//

import Vapor
import SwiftHtml


public struct BlogPostsTemplate: TemplateRepresentable {
    var context: BlogPostsContext
    
    public init(_ context: BlogPostsContext) {
        self.context = context
    }
    
    public func render(_ req: Request) -> Tag {
        WebIndexTemplate(.init(title: context.title)) {
            Div {
                Section {
                    P(context.icon)
                    H1(context.title)
                    P(context.message)
                }
                .class("lead")
                
                Div {
                    for post in context.posts {
                        Article {
                            A {
                                Img(src: post.image, alt: post.title)
                                H2(post.title)
                                P(post.excerpt)
                            }
                            .href("/\(post.slug)/")
                        }
                    }
                }
                .class("grid-221")
            }
            .id("blog")
        }
        .render(req)
    }
}
