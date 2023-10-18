//
//  AdminDetailPageContext.swift
//
//
//  Created by Mico Miloloza on 18.10.2023..
//

import Foundation


public struct AdminDetailPageContext {
    public let title: String
    public let fields: [DetailContext]
    public let navigation: [LinkContext]
    public let breadcrumbs: [LinkContext]
    public let actions: [LinkContext]
    
    public init(title: String, fields: [DetailContext], navigation: [LinkContext] = [], breadcrumbs: [LinkContext] = [], actions: [LinkContext] = []) {
        self.title = title
        self.fields = fields
        self.navigation = navigation
        self.breadcrumbs = breadcrumbs
        self.actions = actions
    }
}
