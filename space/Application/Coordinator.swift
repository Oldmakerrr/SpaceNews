//
//  Coordinator.swift
//  space
//
//  Created by Vladimir Berezin on 8.10.23..
//

import UIKit

final class Coordinator {

    var router: Routable?
    let screenFactory: ScreenFactory

    init(screenFactory: ScreenFactory) {
        self.screenFactory = screenFactory
    }
    
}

// MARK: ArticlesViewModelDelegate

extension Coordinator: ArticlesViewModelDelegate {

    func handle(_ route: ArticlesRoute) {
        switch route {
        case .detail(let articleDTO):
            let controller = screenFactory.detailArticleController(article: articleDTO)
            router?.showController(controller, animated: true)
        case .image(let url):
            let controller = screenFactory.imageController(url: url)
            router?.presentController(controller, animated: true)
        }
    }

}



