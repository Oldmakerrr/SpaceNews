//
//  ArticelMapper.swift
//  space
//
//  Created by Vladimir Berezin on 9.9.23..
//

import Foundation

protocol ArticelMapperProtocol {
    func articelCellViewModel(for articel: ArticleDTO) -> ArticleCell.ViewModel
}

final class ArticelMapper: ArticelMapperProtocol {

    func articelCellViewModel(for articel: ArticleDTO) -> ArticleCell.ViewModel {
        ArticleCell.ViewModel(
            title: articel.title,
            iconURL: URL(string: articel.imageUrl),
            date: dateMapping(articel.publishedAt),
            site: articel.newsSite
        )
    }

    private func dateMapping(_ dateString: String) -> String {
        let inputDateFormatterWithoutMilliseconds = DateFormatter()
        inputDateFormatterWithoutMilliseconds.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let inputDateFormatterWithMilliseconds = DateFormatter()
        inputDateFormatterWithMilliseconds.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"

        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "yyyy MM dd"
        outputDateFormatter.locale = .current
        outputDateFormatter.dateStyle = .long

        if let date = inputDateFormatterWithoutMilliseconds.date(from: dateString) {
            return outputDateFormatter.string(from: date)
        }
        if let date = inputDateFormatterWithMilliseconds.date(from: dateString) {
            return outputDateFormatter.string(from: date)
        }
        return ""
    }
}
