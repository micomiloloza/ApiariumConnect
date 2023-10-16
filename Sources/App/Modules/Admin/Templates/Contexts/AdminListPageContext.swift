//
//  AdminListPageContext.swift
//
//
//  Created by Mico Miloloza on 11.10.2023..
//

import Foundation


public struct AdminListPageContext {
    public let title: String
    public let table: TableContext
    public let navigation: [LinkContext]
    public let breadcrumbs: [LinkContext]
    
    public init(title: String, table: TableContext, navigation: [LinkContext] = [], breadcrumbs: [LinkContext] = []) {
        self.title = title
        self.table = table
        self.navigation = navigation
        self.breadcrumbs = breadcrumbs
    }
}
