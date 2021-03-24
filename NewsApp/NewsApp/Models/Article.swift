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

extension ArticleList {
    
    static var all: Resource<ArticleList> = {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(APIKey)")!
        return Resource(url: url)
    }()
    
}

struct Article: Decodable {
    let title: String?
    let description: String?
}
