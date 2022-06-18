//
//  ArticlesViewModel.swift
//  NewsApp
//
//  Created by Matan Dahan on 18/06/2022.
//

import Foundation

@MainActor
final class ArticlesViewModel: ObservableObject {
    @Published var articles: [Article] = []
    private let apiClient = NewsAPI()
    
    func getArticles() async {
        do {
            let results = try await apiClient.getArticles(from: .techCrunch)
            articles = results.articles
        } catch let error as APIError {
            print(error.description)
        } catch {
            print(error.localizedDescription)
        }
    }
}
