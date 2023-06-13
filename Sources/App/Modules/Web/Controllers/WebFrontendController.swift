//
//  WebFrontendController.swift
//  
//
//  Created by Mico Miloloza on 03.06.2023..
//

import Vapor


struct WebFrontendController {
    func homeView(_ req: Request) throws -> Response {
        let context = WebHomeContext(icon: "🐝",
                                     title: "Welcome beekeper",
                                     message: "To the world of bees",
                                     paragraphs: [
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                                        "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                     ],
                                     link: .init(label: "Read the blog", url: "/blog/")
        )
        
        return req.templates.renderHtml(
            WebHomeTemplate(context)
        )
    }
}
