//
//  BlogPostAdminEditTemplate.swift
//  
//
//  Created by Mico Miloloza on 30.09.2023..
//

import Vapor
import SwiftHtml


struct BlogPostAdminEditTemplate: TemplateRepresentable {
    var context: BlogPostAdminEditContext
    
    init(_ context: BlogPostAdminEditContext) {
        self.context = context
    }
    
    func render(_ req: Request) -> Tag {
        AdminIndexTemplate(.init(title: context.title)) {
            Div {
                Section {
                    H1(context.title)
                }
                .class("lead")
                
                context.form.render(req)
            }
            .id("edit")
            .class("container")
        }
        .render(req)
    }
}
