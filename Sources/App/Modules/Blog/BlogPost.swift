//
//  BlogPost.swift
//  
//
//  Created by Mico Miloloza on 12.06.2023..
//

import Foundation



struct BlogPost: Codable {
    let title: String
    let slug: String
    let image: String
    let excerpt: String
    let date: Date
    let category: String?
    let content: String
}
