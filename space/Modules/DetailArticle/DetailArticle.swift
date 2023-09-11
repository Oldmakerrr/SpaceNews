//
//  DetailArticle.swift
//  space
//
//  Created by Vladimir Berezin on 3.9.23..
//

import UIKit
import SnapKit
import SDWebImage

fileprivate struct Constant {
    static let imageHeight: CGFloat = 200
    static let buttonHeight: CGFloat = 50
    static let offset: CGFloat = 10
    static let buttonTitle = "Read More"
}

// MARK: - DetailArticle

final class DetailArticle: UIViewController {
    // MARK: - Private Properties

    private let article: ArticleDTO

    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 26, weight: .heavy)
        return label
    }()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()

    private let summaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()

    private let scrollView = UIScrollView()

    private var moreInfoButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constant.buttonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = Constant.buttonHeight / 2
        button.layer.masksToBounds = true
        return button
    }()

    // MARK: - Init

    init(article: ArticleDTO) {
        self.article = article
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
    }

    // MARK: - Actoins

    @objc
    private func moreInfoButtonHandler() {
        let viewController = WebViewController(url: URL(string: article.url))
        navigationController?.pushViewController(viewController, animated: true)
    }

    // MARK: - Private Methods

    private func configureUI() {
        view.backgroundColor = .systemGray6
        titleLabel.text = article.title
        infoLabel.text = dateMapping(article.publishedAt) + " " + article.newsSite
        imageView.sd_setImage(with: URL(string: article.imageUrl))
        summaryLabel.text = article.summary
    }

    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(imageView)
        scrollView.addSubview(infoLabel)
        scrollView.addSubview(summaryLabel)
        view.addSubview(moreInfoButton)
    }

    private func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(moreInfoButton.snp.top)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(scrollView).offset(Constant.offset)
            $0.trailing.equalTo(view).inset(Constant.offset)
            $0.leading.equalTo(view).offset(Constant.offset)
        }
        imageView.snp.makeConstraints {
            $0.height.equalTo(Constant.imageHeight)
            $0.width.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constant.offset)
        }
        infoLabel.snp.makeConstraints {
            $0.leading.equalTo(scrollView.snp.leading).offset(Constant.offset)
            $0.top.equalTo(imageView.snp.bottom).offset(Constant.offset)
        }
        summaryLabel.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(Constant.offset)
            $0.trailing.equalTo(view).inset(Constant.offset)
            $0.leading.equalTo(view).offset(Constant.offset)
            $0.bottom.equalTo(scrollView.snp.bottom).inset(Constant.offset)
        }
        moreInfoButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(Constant.buttonHeight)
            $0.width.equalTo(view).multipliedBy(0.7)
            $0.centerX.equalToSuperview()
        }
    }

    private func addActions() {
        moreInfoButton.addTarget(self, action: #selector(moreInfoButtonHandler), for: .touchUpInside)
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
