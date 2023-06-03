//
//  WebFrontendController.swift
//  
//
//  Created by Mico Miloloza on 03.06.2023..
//

import Vapor


struct WebFrontendController {
    func homeView(_ req: Request) throws -> Response {
        req.templates.renderHtml(
            WebHomeTemplate(.init(title: "ApiariumConnect", message: "Welcome beekeepers"))
        )
    }
}
