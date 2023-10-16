//
//  AdminFrontendController.swift
//  
//
//  Created by Mico Miloloza on 10.09.2023..
//

import Vapor


public struct AdminFrontendController {
    func dashboardView(_ req: Request) throws -> Response {
        let user = try req.auth.require(AuthenticatedUser.self)
        let template = AdminDashboardTemplate(.init(
            icon: "⚙️",
            title: "Dashboard",
            message: "Welcome \(user.username)")
        )
        
        return req.templates.renderHtml(template)
    }
}
