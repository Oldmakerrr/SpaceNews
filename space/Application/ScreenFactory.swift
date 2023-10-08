//
//  ScreenFactory.swift
//  space
//
//  Created by Vladimir Berezin on 8.10.23..
//

import UIKit

class ScreenFactory {

    func articleController(coordinatorDelegate: ArticlesViewModelDelegate?) -> UIViewController {
        let mapper = ArticelMapper()
        let viewModel = ArticlesViewModel(mapper: mapper, coordinatorDelegate: coordinatorDelegate)
        return ArticlesController(viewModel: viewModel)
    }

    func detailArticleController(article: ArticleDTO) -> UIViewController {
        let mapper = DetailArticleMapper()
        let viewModel = DetailArticleViewModel(article: article, mapper: mapper)
        return DetailArticle(viewModel: viewModel)
    }

    func imageController(url: URL) -> UIViewController {
        let viewModel = ImageControllerViewModel(imageUrl: url)
        return ImageController(viewModel: viewModel)
    }
}
