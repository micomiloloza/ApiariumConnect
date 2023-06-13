//
//  BlogPostTemplate.swift
//  
//
//  Created by Mico Miloloza on 13.06.2023..
//

import Vapor
import SwiftHtml


struct BlogPostTemplate: TemplateRepresentable {
    var dateFormatter: DateFormatter = {
       let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        
        return dateFormatter
    }()
    
    var context: BlogPostContext
    
    public init(_ context: BlogPostContext) {
        self.context = context
    }
    
    func render(_ req: Request) -> Tag {
        WebIndexTemplate(.init(title: context.post.title)) {
            Div {
                Section {
                    P(dateFormatter.string(from: context.post.date))
                    H1(context.post.title)
                    P(context.post.excerpt)
                }
                .class(["lead", "container"])
                
                Img(src: context.post.image, alt: context.post.title)
                
                Article {
                    Text(context.post.content)
                }
                .class("container")
            }
            .id("post")
        }.render(req)
    }
}
