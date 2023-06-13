//
//  NavigationItemTemplate.swift
//  
//
//  Created by Mico Miloloza on 02.06.2023..
//
import Vapor
import SwiftHtml


public struct NavigationItemTemplate: TemplateRepresentable {
    public var context: NavigationItemContext
    
    public init(_ context: NavigationItemContext) {
        self.context = context
    }
    
    public func render(_ req: Request) -> Tag {
        A(context.title)
            .href(context.href)
            .class(context.class, req.url.path == context.href)
    }
}
