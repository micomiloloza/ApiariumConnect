//
//  BlogPostAdminDeleteTemplate.swift
//
//
//  Created by Mico Miloloza on 10.10.2023..
//

import Vapor
import SwiftHtml


public struct BlogPostAdminDeleteTemplate: TemplateRepresentable {
    var context: BlogPostAdminDeleteContext
    
    init(context: BlogPostAdminDeleteContext) {
        self.context = context
    }
    
    public func render(_ req: Request) -> Tag {
        AdminIndexTemplate(.init(title: context.title)) {
            Div {
                Span("🗑 ")
                    .class("icon")
                
                H1(context.title)
                
                P("You are about to permanently delete the<br>`\(context.name)` \(context.type).")
                
                Form {
                    Input()
                        .type(.submit)
                        .class(["button", "destructive"])
                        .style("display: inline")
                        .value("Delete")
                    
                    A("Cancel")
                        .href("/admin/blog/posts/")
                        .class(["button", "cancel"])
                }
                .method(.post)
                .id("delete-form")
                
            }.class(["lead", "container", "center"])
        }.render(req)
    }
}
