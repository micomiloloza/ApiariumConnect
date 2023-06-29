//
//  UserFrontendController.swift
//  
//
//  Created by Mico Miloloza on 29.06.2023..
//

import Vapor


struct UserFrontendController {
    func signInView(_ req: Request) throws -> Response {
        let context = UserLoginContext(
            icon: "✍🏽",
            title: "Sign in",
            message: "Welcome beekeeper")
        
        return req.templates.renderHtml(UserLoginTemplate(context))
    }
    
    func signInAction(_ req: Request) throws -> Response {
        return Response(status: .ok)
    }
}
