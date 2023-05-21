//
//  ApiManager.swift
//  UnsplashImageapp
//
//  Created by Gagan Vishal  on 2023/05/16.
//

import Foundation

protocol ApiManagerProtocol {
    init(session: URLSession)
    func callService<T: Codable>(endPoint: EndPointProtocol,  model: T.Type) async throws -> T?
}

class ApiManager: ApiManagerProtocol {
    private let session: URLSession
    // MARK: - init
    required init(session: URLSession = .shared) {
        self.session = session
    }
    
    func callService<T>(endPoint: EndPointProtocol, model: T.Type) async throws -> T? where T : Decodable, T : Encodable {
        guard let url = endPoint.url else {
            throw APIError.invalidURL
        }
        let (data, response) = try await session.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw APIError.serverError
        }
        return try? JSONDecoder().decode(model, from: data)
    }
}
