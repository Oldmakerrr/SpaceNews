//
//  ArticleCell.swift
//  space
//
//  Created by Vladimir Berezin on 3.9.23..
//

import UIKit
import SnapKit
import SDWebImage

protocol ArticleCellDelegate: AnyObject {
    func didImageTap(_ cell: ArticleCell)
}

fileprivate struct Constant {
    static let offset: CGFloat = 10
    static let imageViewCornerRadius: CGFloat = 8
}

final class ArticleCell: UICollectionViewCell {

    weak var delegate: ArticleCellDelegate?

    struct ViewModel {
        let title: String
        let iconURL: URL?
        let date: String
        let site: String
    }

    static var identifier: String {
        String(describing: self)
    }

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    private var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Constant.imageViewCornerRadius
        imageView.layer.masksToBounds = true
        return imageView
    }()
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    private var siteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        addGesture()
        backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureUI(_ viewModel: ViewModel) {
        titleLabel.text = viewModel.title
        iconView.sd_setImage(with: viewModel.iconURL)
        dateLabel.text = viewModel.date
        siteLabel.text = viewModel.site
    }

    func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTaphandle))
        tapGesture.numberOfTapsRequired = 1
        iconView.addGestureRecognizer(tapGesture)
        iconView.isUserInteractionEnabled = true
    }

    @objc
    private func imageTaphandle() {
        delegate?.didImageTap(self)
    }

    private func setupUI() {
        addSubview(titleLabel)
        addSubview(iconView)
        addSubview(dateLabel)
        addSubview(siteLabel)
    }

    private func setupConstraints() {
        iconView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(Constant.offset)
            $0.trailing.equalToSuperview().inset(Constant.offset)
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Constant.offset)
            $0.trailing.equalToSuperview().inset(Constant.offset)
            $0.top.equalTo(iconView.snp.bottom).offset(Constant.offset)
        }
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constant.offset)
            $0.leading.equalToSuperview().offset(Constant.offset)
            $0.bottom.equalToSuperview().inset(Constant.offset)
        }
        siteLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constant.offset)
            $0.trailing.equalToSuperview().inset(Constant.offset)
        }
    }
}
