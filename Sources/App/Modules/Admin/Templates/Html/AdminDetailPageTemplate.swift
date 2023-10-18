//
//  AdminDetailPageTemplate.swift
//
//
//  Created by Mico Miloloza on 18.10.2023..
//

import Vapor
import SwiftHtml


struct AdminDetailPageTemplate: TemplateRepresentable {
    var context: AdminDetailPageContext
    
    public init(_ context: AdminDetailPageContext) {
        self.context = context
    }
    
    func render(_ req: Request) -> Tag {
        AdminIndexTemplate(
            .init(
                title: context.title,
                breadcrumbs: context.breadcrumbs
            )
        ) {
            Div {
                Div {
                    H1(context.title)
                    for item in context.navigation {
                        LinkTemplate(item).render(req)
                    }
                }
                .class("lead")
                Dl {
                    for item in context.fields {
                        DetailTemplate(item).render(req)
                    }
                }
                Section {
                    for item in context.actions {
                        LinkTemplate(item).render(req)
                    }
                }
            }
            .class("container")
        }
        .render(req)
    }
}
