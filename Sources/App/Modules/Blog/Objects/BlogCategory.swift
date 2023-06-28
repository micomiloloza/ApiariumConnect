//
//  BlogCategory.swift
//  
//
//  Created by Mico Miloloza on 28.06.2023..
//

import Foundation


public extension Blog.Category {
    struct List: Codable {
        let id: UUID
        let title: String
    }
}
