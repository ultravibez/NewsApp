//
//  ContentView.swift
//  NewsApp
//
//  Created by Matan Dahan on 18/06/2022.
//

import SwiftUI

struct ArticleListView: View {
    // We are adding this boolean to avoid calling get articles twice
    @State private var shouldRefresh = false
    @State private var isLoading = false
    @Environment(\.scenePhase) var scenaPhase
    @StateObject var viewModel = ArticlesViewModel()
    
    var body: some View {
        ZStack {
            List(viewModel.articles) { atricle in
                ArticleListCell(article: atricle)
            }
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .indigo))
                    .scaleEffect(3.0)
            }
        }
        .onChange(of: scenaPhase, perform: { newValue in
            Task {
                if newValue == .active && shouldRefresh {
                    await getArticles()
                    shouldRefresh = false
                } else if newValue == .background {
                    shouldRefresh = true
                }
            }
        })
        .onAppear {
            Task {
                await getArticles()
            }
        }
    }
    
    func getArticles() async {
        isLoading = true
        await viewModel.getArticles()
        isLoading = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView()
    }
}
