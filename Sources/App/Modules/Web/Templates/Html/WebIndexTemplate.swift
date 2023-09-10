//
//  WebIndexTemplate.swift
//  
//
//  Created by Mico Miloloza on 31.05.2023..
//

import Vapor
import SwiftHtml
import SwiftSvg


public struct WebIndexTemplate: TemplateRepresentable {
    public var context: WebIndexContext
    var body: Tag
    
    init(_ context: WebIndexContext,
         @TagBuilder _ builder: () -> Tag) {
        self.context = context
        self.body = builder()
    }
    
    public func render(_ req: Request) -> Tag {
        Html {
            Head {
                Meta()
                    .charset("utf-8")
                Meta()
                    .name(.viewport)
                    .content("width=device-width, initial-scale=1")
                Link(rel: .shortcutIcon)
                    .href("/img/favicon.ico")
                    .type("image/x-icon")
                Link(rel: .stylesheet)
                    .href("https://cdn.jsdelivr.net/gh/feathercms/feather-core@1.0.0-beta.44/feather.min.css")
                Link(rel: .stylesheet)
                    .href("/css/web.css")
                
                Title(context.title)
            }
            Body {
                Header {
                    if req.auth.has(AuthenticatedUser.self) {
                        let navigationItemContexts: [NavigationItemContext] = [
                            .init(title: "Home", href: "/", class: "selected"),
                            .init(title: "Blog", href: "/blog/", class: "selected"),
                            .init(title: "About", href: "#", class: "selected", onClick: "javascript:about();"),
                            .init(title: "Admin", href: "/admin/", class: "selected"),
                            .init(title: "Sign out", href: "/sign-out/", class: "selected")
                        ]
                        
                        NavigationTemplate(.init(items: navigationItemContexts)).render(req)
                    }
                    else {
                        let navigationItemContexts: [NavigationItemContext] = [
                            .init(title: "Home", href: "/", class: "selected"),
                            .init(title: "Blog", href: "/blog/", class: "selected"),
                            .init(title: "About", href: "#", class: "selected", onClick: "javascript:about();"),
                            .init(title: "Sign in", href: "/sign-in/", class: "selected")
                        ]
                        
                        NavigationTemplate(.init(items: navigationItemContexts)).render(req)
                    }
                }
                
                Main {
                    body
                }
                
                Footer {
                    Section {
                        P {
                            Text("This site is powered by ")
                            A("Swift")
                                .href("https://swift.org")
                                .target(.blank)
                            Text(" & ")
                            A("Vapor")
                                .href("https://vapor.codes")
                                .target(.blank)
                            Text(".")
                        }
                        P("ApiariumConnect &copy; 2023")
                    }
                }
                
                Script()
                    .type(.javascript)
                    .src("/js/web.js")
            }
        }
        .lang("en-US")
    }
}
