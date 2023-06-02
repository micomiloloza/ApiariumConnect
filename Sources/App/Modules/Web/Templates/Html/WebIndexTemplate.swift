//
//  WebIndexTemplate.swift
//  
//
//  Created by Mico Miloloza on 31.05.2023..
//

import Vapor
import SwiftHtml
import SwiftSvg


extension Svg {
    static func menuIcon() -> Svg {
        Svg {
            Line(x1: 3, y1: 12, x2: 21, y2: 12)
            Line(x1: 3, y1: 6, x2: 21, y2: 6)
            Line(x1: 3, y1: 18, x2: 21, y2: 18)
        }
        .width(24)
        .height(24)
        .viewBox(minX: 0, minY: 0, width: 24, height: 24)
        .fill("none")
        .stroke("currentColor")
        .strokeWidth(2)
        .strokeLinecap("round")
        .strokeLinejoin("round")
    }
}


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
                    NavigationTemplate(.init(items: [
                        .init(title: "Home", href: "/", class: "selected"),
                        .init(title: "Blog", href: "/blog/", class: "selected")
                    ])).render(req)
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
