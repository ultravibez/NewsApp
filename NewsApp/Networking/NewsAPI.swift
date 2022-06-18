//
//  NewsAPI.swift
//  NewsApp
//
//  Created by Matan Dahan on 18/06/2022.
//

import Foundation

class NewsAPI {
    private let APIKey = Constants.NewsAPIKey
    private let baseURLComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "newsapi.org"
        components.path = "/v2/everything"
        return components
    }()

    
    func request<M: Model>(
        model: M.Type = M.self,
        from path: String,
        with decoder: JSONDecoder = M.decoder
    ) async throws -> M {
        
        var baseComponents = baseURLComponents
        baseComponents.queryItems = [
            URLQueryItem(name: "domains", value: path),
            URLQueryItem(name: "apiKey", value: APIKey)
        ]
        
        guard let fullPath = baseComponents.url else {
            throw APIError.invalidRequestURL
        }
        
        let request = URLRequest(url: fullPath)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let response = response as? HTTPURLResponse,
           !(200...299 ~= response.statusCode) {
            throw APIError.apiError
        }
        
        do {
            return try decoder.decode(M.self, from: data)
        } catch {
            throw APIError.decodingFailed(type: M.self,
                                          message: error.localizedDescription)
        }
    }
}

extension NewsAPI {
    func getArticles(from domain: Domain) async throws -> Results<Article> {
        try await request(from: domain.rawValue)
    }
    
    func getArticles(from domains: [Domain]) async throws -> Results<Article> {
        let joinedDomains = domains.map(\.rawValue)
            .joined(separator: ",")
        return try await request(from: joinedDomains)
    }
}
