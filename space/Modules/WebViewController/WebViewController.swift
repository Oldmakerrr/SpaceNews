//
//  WebViewController.swift
//  space
//
//  Created by Vladimir Berezin on 3.9.23..
//

import UIKit
import WebKit
import SnapKit

// MARK: - WebViewController

final class WebViewController: UIViewController {
    // MARK: - Private Properties

    private let url: URL?

    private lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        return webView
    }()

    private let indicatorView = UIActivityIndicatorView()

    // MARK: - Init

    init(url: URL?) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LifeCycle

    override func loadView() {
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        loadWebView()
        indicatorView.startAnimating()
    }

    // MARK: - Private Methods

    private func setupUI() {
        view.addSubview(indicatorView)
    }

    private func setupConstraints() {
        indicatorView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }

    private func loadWebView() {
        guard let url else { return }
        let myRequest = URLRequest(url: url)
        webView.load(myRequest)
    }
}

// MARK: - WKNavigationDelegate

extension WebViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicatorView.stopAnimating()
    }
}
