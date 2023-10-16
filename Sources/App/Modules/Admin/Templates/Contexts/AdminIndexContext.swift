//
//  AdminIndexContext.swift
//  
//
//  Created by Mico Miloloza on 10.09.2023..
//

import Foundation


public struct AdminIndexContext {
    let title: String
    let breadcrumbs: [LinkContext]
    
    public init(title: String, breadcrumbs: [LinkContext] = []) {
        self.title = title
        self.breadcrumbs = breadcrumbs
    }
}
