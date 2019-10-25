//
//  ItemQuery.swift
//  Exchange
//
//  Created by Eduardo Marquez on 10/18/19.
//  Copyright © 2019 Eduardo Marquez. All rights reserved.
//

import Foundation
import Combine

struct ItemQuery {
    enum QueryError: Error {
        case badURL
        case other(Error)
        case emptyList
        
        var localizedDescription: String {
            switch self {
            case .badURL:
                return "Failed to generate proper URL."
            case .other(let error):
                return "\(error.localizedDescription)"
            case .emptyList:
                return "No items match your query."
            }
        }
    }
    
    func url(itemType: Int?, query: String?, page: Int) -> URL? {
        var components = URLComponents()
        components.host = "www.romexchange.com"
        components.scheme = "https"
        components.path = "/api"
        if let query = query {
            components.queryItems = [
                URLQueryItem(name: "item", value: "\(query)"),
                URLQueryItem(name: "exact", value: "false"),
                URLQueryItem(name: "page", value: "\(page)")
            ]
        } else if let itemType = itemType {
            components.queryItems = [
                URLQueryItem(name: "type", value: "\(itemType)"),
                URLQueryItem(name: "page", value: "\(page)")
            ]
        }
        return components.url
    }
    
    func getItems(itemType: Int?,
                  query: String?,
                  page: Int,
                  completion: @escaping (Result<[Item], QueryError>) -> Void) -> AnyCancellable? {
        guard let url = url(itemType: itemType,
                            query: query,
                            page: page) else {
            completion(.failure(QueryError.badURL))
            return nil
        }
        print(url.absoluteString)
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Item].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { sinkCompletion in
                switch sinkCompletion {
                case .finished:
                    break
                case .failure(let error):
                    print(url)
                    print(error)
                    completion(.failure(QueryError.other(error)))
                }
            }, receiveValue: { items in
                if items.isEmpty {
                    completion(.failure(QueryError.emptyList))
                } else {
                    completion(.success(items))
                }
            })
    }
}
