//
//  WebLinkTemplate.swift
//  
//
//  Created by Mico Miloloza on 12.06.2023..
//

import Vapor
import SwiftHtml


public struct WebLinkTemplate: TemplateRepresentable {
    var context: WebLinkContext
    
    public init(_ context: WebLinkContext) {
        self.context = context
    }
    
    public func render(_ req: Request) -> Tag {
        A(context.label)
            .href(context.url)
    }
}
