//
//  AdminListPageTemplate.swift
//
//
//  Created by Mico Miloloza on 11.10.2023..
//

import Vapor
import SwiftHtml


public struct AdminListPageTemplate: TemplateRepresentable {
    var context: AdminListPageContext
    
    public init(_ context: AdminListPageContext) {
        self.context = context
    }
    
    public func render(_ req: Request) -> Tag {
        AdminIndexTemplate(.init(title: context.title, breadcrumbs: context.breadcrumbs)) {
            Div {
                H1(context.title)
                P {
                    context.navigation.map { LinkTemplate($0).render(req) }
                }
            }
            .class("lead")
            
            if context.table.rows.isEmpty {
                Div {
                    Span("🔍")
                        .class("icon")
                    H2("This list is empty right now.")
                    A("Try again")
                        .href(req.url.path)
                        .class("button-1")
                }
                .class(["lead", "container", "center"])
            } else {
                TableTemplate(context: context.table).render(req)
            }
        }
        .render(req)
    }
}
