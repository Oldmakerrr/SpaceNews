//
//  ArticleDTO.swift
//  space
//
//  Created by Vladimir Berezin on 3.9.23..
//

import Foundation

struct SpaceflightDTO: Codable {
    let count: Int
    let next: String
    let previous: String?
    let results: [ArticleDTO]
}

struct ArticleDTO: Codable {
    let id: Int
    let title: String
    let url: String
    let imageUrl: String
    let newsSite: String
    let summary: String
    let publishedAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case url
        case imageUrl = "image_url"
        case newsSite = "news_site"
        case summary
        case publishedAt = "published_at"
        case updatedAt = "updated_at"
    }
}

enum RestError: Error {
    case invalidURL
    case invalidJSON
    case serverError(String)
}
