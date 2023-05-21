//
//  EndPoint.swift
//  UnsplashImageapp
//
//  Created by Gagan Vishal  on 2023/05/16.
//

import Foundation

protocol EndPointProtocol {
    var url: URL? {get}
    var baseURLString: String { get }
}

extension EndPointProtocol {
    var baseURLString: String {
        "api.unsplash.com"
    }
}

enum EndPoint: EndPointProtocol {
    case allTopics
    case photos(page: Int, contentFilter: String)
    
    var path: String {
        switch self {
        case .allTopics:
            return "/topics"
        case .photos( _, _):
            return "/photos"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .allTopics:
            return [URLQueryItem(name: "client_id", value: APIKey.unsplashAPIKey)]
        case .photos(let page, let contentFilter):
            return [
                URLQueryItem(name: "client_id", value: APIKey.unsplashAPIKey),
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "content_filter", value: contentFilter)
            ]
        }
    }
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = baseURLString
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
}
