//
//  BlogPostAdminDetailTemplate.swift
//  
//
//  Created by Mico Miloloza on 28.09.2023..
//

import Vapor
import SwiftHtml


public struct BlogPostAdminDetailTemplate: TemplateRepresentable {
    var context: BlogPostAdminDetailContext
    
    init(_ context: BlogPostAdminDetailContext) {
        self.context = context
    }
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        
        return formatter
    }
    
    public func render(_ req: Vapor.Request) -> Tag {
        AdminIndexTemplate(.init(title: context.title)) {
            Div {
                Section {
                    H1(context.title)
                }
                .class("lead")
                Dl {
                    Dt("Image")
                    Dd {
                        Img(
                            src: context.detail.image,
                            alt: context.detail.title
                        )
                    }
                    
                    Dt("Title")
                    Dd(context.detail.title)
                    Dt("Excerpt")
                    Dd(context.detail.excerpt)
                    Dt("Date")
                    Dd(dateFormatter.string(from: context.detail.date))
                    Dt("Content")
                    Dd(context.detail.content)
                }
            }
            .id("detail")
            .class("container")
        }
        .render(req)
    }
}
