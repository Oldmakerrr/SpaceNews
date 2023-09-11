//
//  ArticlesViewModel.swift
//  space
//
//  Created by Vladimir Berezin on 9.9.23..
//

import Foundation

protocol ArticlesViewModelProtocol {
    var articlesCount: Int { get }

    func articel(for indexPath: IndexPath) -> ArticleDTO
    func articlesCellViewModel(_ articel: ArticleDTO) -> ArticleCell.ViewModel
    func refresh()

    // Binding
    var didFetchData: (() -> Void)? { get set }
    var didFetchDataWithFailer: (() -> Void)? { get set }
}

final class ArticlesViewModel: ArticlesViewModelProtocol {
    // MARK: - Private Properties

    private let mapper: ArticelMapperProtocol
    private var articles: [ArticleDTO] = []
    private var currentPage = 1

    // MARK: - Public Properties

    var didFetchData: (() -> Void)?
    var didFetchDataWithFailer: (() -> Void)?

    var articlesCount: Int {
        articles.count
    }

    //MARK: - Init

    init(mapper: ArticelMapperProtocol) {
        self.mapper = mapper
        fetchData(page: currentPage)
    }

    // MARK: - Public Methods

    func articel(for indexPath: IndexPath) -> ArticleDTO {
        articles[indexPath.row]
    }

    func articlesCellViewModel(_ articel: ArticleDTO) -> ArticleCell.ViewModel {
        mapper.articelCellViewModel(for: articel)
    }

    func refresh() {
        currentPage += 1
        fetchData(page: currentPage)
    }

    // MARK: - Private Methods

    private func fetchData(page: Int) {
        let networkService = ArticlesNetworkService()
        networkService.fetchData(page: page) { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles.results
                self?.didFetchData?()
            case .failure(let error):
                print(error.localizedDescription)
                self?.didFetchDataWithFailer?()
            }
        }
    }

    private func goToDetailNews(with article: ArticleDTO) {
        let viewController = DetailArticle(article: article)
//        navigationController?.pushViewController(viewController, animated: true)
    }
}
