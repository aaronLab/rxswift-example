//
//  Article.swift
//  NewsExample
//
//  Created by Aaron Lee on 2021-04-05.
//

import Foundation

struct ArticleResponse: Decodable {
    
    let articles: [Article]
    
}

struct Article: Decodable {
    
    let title: String
    let description: String?
    
}
