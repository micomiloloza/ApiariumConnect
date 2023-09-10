//
//  AdminDashboardTemplate.swift
//  
//
//  Created by Mico Miloloza on 10.09.2023..
//

import Vapor
import SwiftHtml


public struct AdminDashboardTemplate: TemplateRepresentable {
    let context: AdminDashboardContext
    
    public func render(_ req: Request) -> Tag {
        AdminIndexTemplate(.init(title: context.title)) {
            Div {
                Section {
                    P(context.icon)
                    H1(context.title)
                    P(context.message)
                }
            }
            .id("dashboard")
            .id("container")
        }
        .render(req)
    }
}
