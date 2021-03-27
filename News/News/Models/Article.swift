//
//  Article.swift
//  News
//
//  Created by Aaron Lee on 2021/03/27.
//

import Foundation

struct ArticleResponse: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let description: String?
}
