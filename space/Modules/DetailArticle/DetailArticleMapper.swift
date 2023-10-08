//
//  DetailArticleMapper.swift
//  space
//
//  Created by Vladimir Berezin on 8.10.23..
//

import Foundation

final class DetailArticleMapper {

    func info(_ article: ArticleDTO) -> String {
        let inputDateFormatterWithoutMilliseconds = DateFormatter()
        inputDateFormatterWithoutMilliseconds.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let inputDateFormatterWithMilliseconds = DateFormatter()
        inputDateFormatterWithMilliseconds.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"

        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "yyyy MM dd"
        outputDateFormatter.locale = .current
        outputDateFormatter.dateStyle = .long

        if let date = inputDateFormatterWithoutMilliseconds.date(from: article.publishedAt) {
            return outputDateFormatter.string(from: date) + " " + article.newsSite
        }
        if let date = inputDateFormatterWithMilliseconds.date(from: article.publishedAt) {
            return outputDateFormatter.string(from: date) + " " + article.newsSite
        }
        return ""
    }
}
