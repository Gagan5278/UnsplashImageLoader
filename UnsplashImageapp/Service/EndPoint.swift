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
    case searchPhoto(page: Int, searchItem: String)
    case downloadImage(urlString: String)
    
    private var path: String {
        switch self {
        case .allTopics:
            return "/topics"
        case .photos( _, _):
            return "/photos"
        case .searchPhoto(_, _):
            return "/search/photos"
        case .downloadImage(_):
            return ""
        }
    }
    
    private var queryItems: [URLQueryItem] {
        switch self {
        case .allTopics:
            return [URLQueryItem(name: "client_id", value: APIKey.unsplashAPIKey)]
        case .photos(let page, let contentFilter):
            return [
                URLQueryItem(name: "client_id", value: APIKey.unsplashAPIKey),
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "content_filter", value: contentFilter)
            ]
        case .searchPhoto(let page, let searchItem):
            return [
                URLQueryItem(name: "client_id", value: APIKey.unsplashAPIKey),
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "query", value: searchItem)
            ]
        case .downloadImage(_):
            return [
                URLQueryItem(name: "client_id", value: APIKey.unsplashAPIKey),
            ]
        }
    }
    
    var url: URL? {
        switch self {
        case .allTopics, .photos(_, _), .searchPhoto(_, _):
            var components = URLComponents()
            components.scheme = "https"
            components.host = baseURLString
            components.path = path
            components.queryItems = queryItems
            return components.url
        case .downloadImage(let urlString):
            var components = URLComponents(string: urlString)
            components?.queryItems = queryItems
            return components?.url
        }
    }
}
