//
//  AdminDashboardTemplate.swift
//  
//
//  Created by Mico Miloloza on 10.09.2023..
//

import Vapor
import SwiftHtml


public struct AdminDashboardTemplate: TemplateRepresentable {
    var context: AdminDashboardContext
    
    init(_ context: AdminDashboardContext) {
        self.context = context
    }
    
    public func render(_ req: Request) -> Tag {
        AdminIndexTemplate(.init(title: context.title)) {
            Div {
                Section {
                    P(context.icon)
                    H1(context.title)
                    P(context.message)
                }
                
                Nav {
                    H2("Blog")
                    Ul {
                        Li {
                            A("Posts")
                                .href("/admin/blog/posts/")
                        }
                        Li {
                            A("Categories")
                                .href("/admin/blog/categories/")
                        }
                    }
                }
            }
            .id("dashboard")
            .id("container")
        }
        .render(req)
    }
}
