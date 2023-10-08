//
//  DetailArticleViewModel.swift
//  space
//
//  Created by Vladimir Berezin on 8.10.23..
//

import Foundation

protocol DetailArticleViewModelProtocol {
    var title: String { get }
    var info: String { get }
    var imageUrl: URL? { get }
    var summary: String { get }
}

final class DetailArticleViewModel: DetailArticleViewModelProtocol {

    var title: String { article.title }

    var info: String { mapper.info(article) }

    var imageUrl: URL? { URL(string: article.imageUrl) }

    var summary: String { article.summary }

    private let article: ArticleDTO
    private let mapper: DetailArticleMapper

    init(article: ArticleDTO, mapper: DetailArticleMapper) {
        self.article = article
        self.mapper = mapper
    }

}
