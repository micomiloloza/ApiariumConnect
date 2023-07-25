//
//  WebHomeTemplate.swift
//  
//
//  Created by Mico Miloloza on 03.06.2023..
//

import Vapor
import SwiftHtml


public struct WebHomeTemplate: TemplateRepresentable {
    public var context: WebHomeContext
    
    public init(_ context: WebHomeContext) {
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
                
                for paragraph in context.paragraphs {
                    P(paragraph)
                }
                
                WebLinkTemplate(context.link).render(req)
            }
            .id("home")
            .class("container")
        }
        .render(req)
    }
}

