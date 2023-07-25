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
    
    func renderSignInView(_ req: Request, form: UserLoginForm) -> Response {
        let context = UserLoginContext(
            icon: "✍🏽",
            title: "Sign in",
            message: "Welcome beekeeper",
            form: form.render(req: req)
        )
        
        return req.templates.renderHtml(UserLoginTemplate(context))
    }
    
    func signInView(_ req: Request) throws -> Response {
        renderSignInView(req, form: .init())
    }
    
    func signInAction(_ req: Request) async throws -> Response {
        // If user is authenticated we store data in session too.
        if let user = req.auth.get(AuthenticatedUser.self) {
            req.session.authenticate(user)
            return req.redirect(to: "/")
        }
        
        var form = UserLoginForm()
        
        try await form.process(req: req)
        form.error = "Invalid email or password"
        
        return renderSignInView(req, form: form)
    }
    
    func signOutAction(_ req: Request) throws -> Response {
        req.auth.logout(AuthenticatedUser.self)
        req.session.unauthenticate(AuthenticatedUser.self)
        
        return req.redirect(to: "/")
    }
}
