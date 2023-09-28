//
//  BlogPostAdminListTemplate.swift
//  
//
//  Created by Mico Miloloza on 10.09.2023..
//

import Vapor
import SwiftHtml


struct BlogPostAdminListTemplate: TemplateRepresentable {
    let context: BlogPostAdminListContext
    
    init(_ context: BlogPostAdminListContext) {
        self.context = context
    }
    
    func render(_ req: Request) -> Tag {
        AdminIndexTemplate(.init(title: context.title)) {
            Div {
                Section {
                    H1(context.title)
                }
                .class("lead")
                Table {
                    Thead {
                        Tr {
                            Th("Image")
                            Th("Title")
                            Th("Preview")
                        }
                    }
                    Tbody {
                        for item in context.list {
                            Tr {
                                Td {
                                    Img(src: item.image, alt: item.title)
                                        .height(20)
                                        .width(20)
                                }
                                Td {
                                    A(item.title)
                                        .href("/admin/blog/posts/\(item.id.uuidString)/")
                                }
                                    
                                Td {
                                    A("Preview")
                                        .href("/" + item.slug + "/")
                                }
                            }
                        }
                    }
                }
            }
            .id("list")
        }.render(req)
    }
}
