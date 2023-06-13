//
//  BlogFrontendController.swift
//  
//
//  Created by Mico Miloloza on 13.06.2023..
//

import Vapor


struct BlogFrontendController {
    var posts: [BlogPost] = {
        stride(from: 1, to: 3, by: 1).map { index in
            return BlogPost(title: "Sample post \(index)",
                            slug: "sample-post-\(index)",
                            image: "/img/posts/\(String(format: "%02d", index)).jpg",
                            excerpt: "Lorem ipsum",
                            date: Date().addingTimeInterval(-Double.random(in: 0...(86400 * 60))),
                            category: Bool.random() ? "Sample category" : nil,
                            content: "Lorem ipsum dolor sit amet."
            )
        }.sorted(by: { $0.date > $1.date })
    }()
}
