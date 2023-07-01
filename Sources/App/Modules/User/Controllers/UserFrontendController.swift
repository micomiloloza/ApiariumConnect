//
//  UserFrontendController.swift
//  
//
//  Created by Mico Miloloza on 29.06.2023..
//

import Vapor


struct UserFrontendController {
    struct Input: Decodable {
        let email: String?
        let password: String?
    }
    
    func renderSignInView(_ req: Request, input: Input? = nil, error: String? = nil) -> Response {
        let context = UserLoginContext(
            icon: "✍🏽",
            title: "Sign in",
            message: "Welcome beekeeper",
            email: input?.email,
            password: input?.password,
            error: error
        )
        
        return req.templates.renderHtml(UserLoginTemplate(context))
    }
    
    func signInView(_ req: Request) throws -> Response {
        renderSignInView(req)
    }
    
    func signInAction(_ req: Request) throws -> Response {
        // If user is authenticated we store data in session too.
        if let user = req.auth.get(AuthenticatedUser.self) {
            req.session.authenticate(user)
            return req.redirect(to: "/")
        }
        
        let input = try req.content.decode(Input.self)
        
        return renderSignInView(req, input: input, error: "Invalid email or password")
    }
    
    func signOutAction(_ req: Request) throws -> Response {
        req.auth.logout(AuthenticatedUser.self)
        req.session.unauthenticate(AuthenticatedUser.self)
        
        return req.redirect(to: "/")
    }
}
