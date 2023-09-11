//
//  ArticlesNetworkService.swift
//  space
//
//  Created by Vladimir Berezin on 3.9.23..
//

import Foundation

fileprivate struct Constant {
    static let articlesURL = "https://api.spaceflightnewsapi.net/v4/articles/"

    static let eventKey = "has_event"
    static let eventValue = "false"
    static let launchKey = "has_launch"
    static let launchValue = "false"
    static let offsetKey = "offset"
    static let limitKey = "limit"
}

final class ArticlesNetworkService {
    func fetchData(
        limit: Int = 15,
        page: Int,
        completion: @escaping (Result<SpaceflightDTO, RestError>) -> Void
    ) {
        guard var urlComponents = URLComponents(string: Constant.articlesURL) else { return }
        urlComponents.queryItems = [
            URLQueryItem(name: Constant.eventKey, value: Constant.eventValue),
            URLQueryItem(name: Constant.launchKey, value: Constant.launchValue),
            URLQueryItem(name: Constant.offsetKey, value: String(limit * page)),
            URLQueryItem(name: Constant.limitKey, value: String(limit)),
        ]
        guard let url = urlComponents.url else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(.serverError(error.localizedDescription)))
            } else if let data = data {
                if let spaceflight: SpaceflightDTO = self.parseJson(data) {
                    DispatchQueue.main.async {
                        completion(.success(spaceflight))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(.invalidJSON))
                    }
                }
            }
        }
        task.resume()
    }

    private func parseJson<T: Codable>(_ data: Data) -> T? {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Ошибка при разборе JSON: \(error.localizedDescription)")
            return nil
        }
    }
}
