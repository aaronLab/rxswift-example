//
//  Article.swift
//  NewsApp
//
//  Created by Aaron Lee on 2021/03/24.
//

import Foundation

struct ArticleList: Decodable {
    let articles: [Article]?
}

struct Article: Decodable {
    let title: String?
    let description: String?
}
