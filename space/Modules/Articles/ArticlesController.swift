//
//  ArticlesController.swift
//  space
//
//  Created by Vladimir Berezin on 3.9.23..
//

import UIKit
import SnapKit
import SDWebImage

fileprivate struct Constant {
    static let title = "News"
    static let collectionViewInsets = UIEdgeInsets(top: 10, left: .zero, bottom: 10, right: .zero)
}

// MARK: - ArticlesController

final class ArticlesController: UIViewController {
    // MARK: - Private Properties

    var viewModel: ArticlesViewModelProtocol

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = Constant.collectionViewInsets
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.width/2)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.register(ArticleCell.self, forCellWithReuseIdentifier: ArticleCell.identifier)
        return collectionView
    }()

    private let refreshControl = UIRefreshControl()

    init(viewModel: ArticlesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupUI()
        setupConstraints()
        addActions()

        viewModel.didFetchData = { [weak self] in
            self?.reloadData()
        }
        viewModel.didFetchDataWithFailer = { [weak self] in
            // show alert
            self?.reloadData()
        }
    }

    // MARK: - Actoins

    @objc
    private func refreshData() {
        viewModel.refresh()
    }
    
    // MARK: - Private Methods

    private func reloadData() {
        collectionView.reloadData()
        refreshControl.endRefreshing()
    }

    private func configureUI() {
        title = Constant.title
        collectionView.refreshControl = refreshControl
        view.backgroundColor = .systemGray6
    }

    private func setupUI() {
        view.addSubview(collectionView)
    }

    private func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func addActions() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
}

// MARK: - UICollectionViewDataSource

extension ArticlesController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.articlesCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ArticleCell.identifier,
            for: indexPath
        ) as? ArticleCell else {
            return UICollectionViewCell()
        }

        let article = viewModel.articel(for: indexPath)
        let viewModel = viewModel.articlesCellViewModel(article)
        cell.configureUI(viewModel)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension ArticlesController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = viewModel.articel(for: indexPath)
//        goToDetailNews(with: article)
    }
}
