//
//  UserLoginForm.swift
//  
//
//  Created by Mico Miloloza on 10.07.2023..
//

import Vapor
import SwiftHtml


public class UserLoginForm: AbstractForm {
    public convenience init() {
        self.init(
            action: .init(
                method: .post,
                url: "sign-in"
            ),
            submit: "Sign in"
        )
        
        self.fields = createFields()
    }
    
    @FormComponentBuilder
    private func createFields() -> [FormComponent] {
        InputField("email")
            .config {
                $0.output.context.label.required = true
                $0.output.context.type = .email
            }
        
        InputField("password")
            .config {
                $0.output.context.label.required = true
                $0.output.context.type = .password
            }
    }
}