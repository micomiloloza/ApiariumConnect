//
//  NavigationItemContext.swift
//  
//
//  Created by Mico Miloloza on 02.06.2023..
//


public struct NavigationItemContext {
    var title: String
    var href: String
    var `class`: String
    
    public init(title: String, href: String, `class`: String) {
        self.title = title
        self.href = href
        self.class = `class`
    }
}
