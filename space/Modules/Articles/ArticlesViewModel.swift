//
//  ArticlesViewModel.swift
//  space
//
//  Created by Vladimir Berezin on 9.9.23..
//

import Foundation

protocol ArticlesViewModelDelegate: AnyObject {
    func handle(_ route: ArticlesRoute)
}

protocol ArticlesViewModelProtocol {
    var articlesCount: Int { get }

    func articel(for indexPath: IndexPath) -> ArticleDTO
    func articlesCellViewModel(_ articel: ArticleDTO) -> ArticleCell.ViewModel
    func refresh()
    func goToDetailNews(for indexPath: IndexPath)
    func goToImageController(for indexPath: IndexPath)

    // Binding
    var didFetchData: (() -> Void)? { get set }
    var didFetchDataWithFailer: (() -> Void)? { get set }
}

final class ArticlesViewModel: ArticlesViewModelProtocol {
    // MARK: - Private Properties

    private let mapper: ArticelMapperProtocol
    private var articles: [ArticleDTO] = []
    private var currentPage = 1
    private weak var coordinatorDelegate: ArticlesViewModelDelegate?

    // MARK: - Public Properties

    var didFetchData: (() -> Void)?
    var didFetchDataWithFailer: (() -> Void)?

    var articlesCount: Int {
        articles.count
    }

    //MARK: - Init

    init(mapper: ArticelMapperProtocol, coordinatorDelegate: ArticlesViewModelDelegate?) {
        self.mapper = mapper
        self.coordinatorDelegate = coordinatorDelegate
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

    func goToDetailNews(for indexPath: IndexPath) {
        let article = articles[indexPath.row]
        coordinatorDelegate?.handle(.detail(article))
    }

    func goToImageController(for indexPath: IndexPath) {
        let article = articles[indexPath.row]
        guard let url = URL(string: article.imageUrl) else { return }
        coordinatorDelegate?.handle(.image(url))
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
}
