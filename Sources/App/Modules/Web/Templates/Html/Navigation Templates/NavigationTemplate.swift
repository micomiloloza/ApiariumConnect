//
//  NavigationTemplate.swift
//  
//
//  Created by Mico Miloloza on 02.06.2023..
//

import Vapor
import SwiftHtml
import SwiftSvg


public struct NavigationTemplate: TemplateRepresentable {
    public var context: NavigationContext
    
    init(_ context: NavigationContext) {
        self.context = context
    }
    
    public func render(_ req: Request) -> Tag {
        Div {
            A {
                Img(src: "/img/logo.png", alt: "Logo")
            }
            .id("site-logo")
            .href("/")
            
            Nav {
                Input()
                    .type(.checkbox)
                    .id("primary-menu-button")
                    .name("menu-button")
                    .class("menu-button")
                Label {
                    Svg.menuIcon()
                }
                .for("primary-menu-button")
                        
                Div {
                    for itemContext in context.items {
                        NavigationItemTemplate(itemContext).render(req)
                    }
                    
                    A("About")
                        .href("#")
                        .onClick("javascript:about();")
                }
                .class("menu-items")
            }
            .id("primary-menu")
        }
        .id("navigation")
    }
}
